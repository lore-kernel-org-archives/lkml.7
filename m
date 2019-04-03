Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0B3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EA8206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDCBBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:01:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:45008 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfDCBBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:01:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A2FBAF86;
        Wed,  3 Apr 2019 01:01:02 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>
Date:   Wed, 03 Apr 2019 12:00:54 +1100
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
In-Reply-To: <20190402164824.GK2217@ZenIV.linux.org.uk>
References: <20190327051717.23225-1-tobin@kernel.org> <20190402094934.5b242dc0@lwn.net> <20190402164824.GK2217@ZenIV.linux.org.uk>
Message-ID: <87d0m32989.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02 2019, Al Viro wrote:

> On Tue, Apr 02, 2019 at 09:49:34AM -0600, Jonathan Corbet wrote:
>> On Wed, 27 Mar 2019 16:16:53 +1100
>> "Tobin C. Harding" <tobin@kernel.org> wrote:
>>=20
>> > Hi Al,
>> >=20
>> > This series converts the VFS file Documentation/filesystems/vfs.txt to
>> > reStructuredText format.  Please consider taking this series through
>> > your tree as apposed to Jon's tree because this set makes a fair amount
>> > of changes to VFS files (and also the VFS tree and docs tree are out of
>> > sync right now with the recent work by Mauro and Neil).
>>=20
>> Al, do you have any thoughts on how you want to handle this?  I was about
>> to apply Jeff Layton's vfs.txt update, but would rather not create
>> conflicts unnecessarily.  Let me know if you'd like me to pick this work
>> up.
>
> Frankly, I would rather see that file be eventually replaced by something
> saner, and I'm not talking about the format.  Re Jeff's patch...=20
>
> +  d_prune: called prior to pruning (i.e. unhashing and killing) a hashed
> +       dentry from the dcache.
>
> is flat-out misguiding.  First of all, it *is* called for unhashed dentri=
es,
> TYVM.  Furthermore, "prior to" is far too vague.
>
> What really happens: there's a point in state diagram for dentries where
> we commit to destroying a dentry and start taking it apart.  That transit=
ion
> happens with ->d_lock of dentry, ->i_lock of its inode (if any) and
> ->d_lock of the parent (again, if any) held; ->d_prune() is the last
> chance for filesystem to see the (now doomed) dentry still intact.
>
> It doesn't matter whether it's hashed or not, etc.  The locks held
> are sufficient to stabilize pretty much everything[1] in dentry and
> nothing is destroyed yet.  The only apparent exception is ->d_count,
> but that's not real - we are guaranteed that there had been no other
> counted references to dentry at the decision point and that none
> could've been added.  So this "oh, it's not 0 now, it's gone negative
> after lockref_mark_dead() the caller has just done" is a red herring.
>
> ->d_prune() must not drop/regain any of the locks held by caller.
> It must _not_ free anything attached to dentry - that belongs
> later in the shutdown sequence.  If anything, I'm tempted to
> make it take const struct dentry * as argument, just to make
> that clear.
>
> No new (counted) references can be acquired by that point;
> lockless dcache lookup might find our dentry a match, but
> result of such lookup is not going to be legitimized - it's
> doomed to be thrown out as stale.
>
> It really makes more sense as part of struct dentry lifecycle
> description...=20=20

I would find it useful if the documentation said something about why
this API exists at all.  As you say, it cannot change the dentry - so
what is it expected to do.

I had a look at the two in-tree users and my guess is that it can be
useful if the filesystem caches some other information which would be
invalidated by a dentry being removed.
I *think* cephfs has a flag which records if "All entries in a directory
are currently in the dcache".  When a dentry is pruned, that flag needs
to be cleared.

i.e. ->d_prune allows a filesystem to maintain summary state about what
   is currently in the dcache.
??

Thanks,
NeilBrown

>
> [1] in theory, ->d_time might be changed by overlapping lockless
> call of ->d_revalidate().  Up to filesystem - VFS doesn't touch
> that field (and AFAICS only NFS uses it these days).

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlykBccACgkQOeye3VZi
gbnY0w/+K3LsamZQld1Bpmrss0FtSfkjCHDDdn1D3dzMFizF+1CgCOOcZdr233Lk
zRIGCXDNVVdJrDLL1CDuJVrQPF3euGZc1UljxS4p5cGNKRAZ9HPr3MyHIREyEcM8
Qiq7+PFFf6UAIHAFjPyU1RPliHfLu+TGDdg5qi1OijXESEI4lq8Kdn0Q/a1iO0as
Ky/DYoRnCZIExe98ziJfD4kd+HDmJkFD8Wdmo3vhk+4GglU4s38FP4xYv2ENo6QD
uAvwfaU7LwG3edC1/tU+e8grnW9Nqj7mNGsFTklAKZ8HS0WCbuwG7oKp5u4yxjWK
aRUzVYWYDD1XGShhQgA35l2ABvjpj41ADKu64qR/6tIwGzuqqT8odZiMdmWXML1t
I5SALwY0/HcC2D0GIiAdRRUebhMsX0gRlmPf4OMM5Dv0r2M/UlQ6bqSJKE+AXlKt
W7HlV+NufNJDjTLMPIFI/h25SOK5DZLmK0ZxA7oo1N4nNprTt2GU+M9AB3Gf+Xhg
nXvd08zg996iJSTLzg8J3TJvmzQZVUacup9HbWlVtNKXZs1DoH7nz9+nTnKvyHkd
goEpULSpLGINgDhD5337DNkcFmJIdFunxhK0G15bzeirfITvZDx7jnJN/IuZYY5V
chKek4Ub9zJBaKHkPyubcUfEIYvQ1/foFtQ5h8tul2PeQPOQdnY=
=a+5Z
-----END PGP SIGNATURE-----
--=-=-=--
