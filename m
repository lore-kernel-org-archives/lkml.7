Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CCBC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 22:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E9D216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 22:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRvA9uBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfGEWTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 18:19:44 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34425 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfGEWTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 18:19:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so8997834qkt.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCpfXFWxpyNMzm+Kh4+Mwk70V9P8g4mMyTXJb2deWCQ=;
        b=pRvA9uBQMka1ZEHWHbtxYw/kg+s5MzQMbhRnVrD6JxWXitEDRIDOXhjghiSco769xU
         ThhK3Taz2bdvorMwQea2U4xuloYanAArXMiHkpgvAHlh5Oz4BdwupLknL4JOueupSkRs
         9kArYycXFyZLoM8rGPr98dKNnoHGhAaGPru5E0uPxT6RHaFENyM9J0PQdH1ZxREjzqjS
         oHuCcREnzFD2EV3v2neYz7eHDep/NO4epZsyZIhLP7i6QhdWe6vaWUW+hwUGtZCaz8wS
         41ORr31rf4RtVbRVdGIq6+M1imIcgrDL9LzAAj/a3g5LbD3MvfPQ3ta0pTQ94ZikOpFI
         TfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCpfXFWxpyNMzm+Kh4+Mwk70V9P8g4mMyTXJb2deWCQ=;
        b=Jv3vBRHttp4/hDe8rMvSnkyPCr3KmU+0G+DXZAN2rubXm5oNgK49q/Ljju/iBLZL0K
         NAg6+Gqw61zFjqvjfKWAMyxFL65+i6jFWIZ+iLt/4XSsfQcTBPJ2JNTcJRichOtsxi1G
         LDKTaPUNz5+wlG5+P7b8b92VYEs2mJD/ZpjKN+swWd1P2ffC5z+1yWhyebG6mMWVXBgE
         HBgbJC/sr/SClg6qVylMVIxAarVmykPHm7M9L9S1quWsZ2wXhiH/1tbCGRZGXo4ejR/u
         /f3WxPhLEVUVqFoAVXpSugAa8IhZINrDnWgjvJCgp/E1b6ah0/Kl1opioGBDebhynm32
         CQ4Q==
X-Gm-Message-State: APjAAAXEYwYTLfJPdELPwiWo6UluUKCQPRiQvP759cO1vONQICUxqBYK
        BvwpOBfI6Ktq/VrFCCZejTiZV90eFG+XAIjZo9y7LA==
X-Google-Smtp-Source: APXvYqwEudv2y4L34ISasD4WyPffYxwpWLJZzKhuru8Z557wvcVWzXEd7GHtFrn5AVGtCisZlO/YeZRhXu3FAaJsiuo=
X-Received: by 2002:ae9:eb87:: with SMTP id b129mr4002171qkg.453.1562365183062;
 Fri, 05 Jul 2019 15:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190705163021.142924-1-rburny@google.com> <20190705200218.GZ19023@42.do-not-panic.com>
In-Reply-To: <20190705200218.GZ19023@42.do-not-panic.com>
From:   Radoslaw Burny <rburny@google.com>
Date:   Sat, 6 Jul 2019 00:19:16 +0200
Message-ID: <CAFkxGoMu7Efy+nzkW=HFrbpUdWNCt5x2jGGDRSHHwyd=hhXzrA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Fix the default values of i_uid/i_gid on /proc/sys inodes.
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Sperbeck <jsperbeck@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c732ef058cf67dd4"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c732ef058cf67dd4
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 5, 2019 at 10:02 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
>
> Please re-state the main fix in the commit log, not just the subject.

Sure, I'll do this. Just to make sure - for every iteration on the
commit message, I need to increment the patch "version" and resend the
whole patch, right?

>
> Also, this does not explain why the current values are and the impact to
> systems / users. This would help in determine and evaluating if this
> deserves to be a stable fix.

This commit a (much overdue) resend of https://lkml.org/lkml/2018/11/30/990
I think Eric's comment on the previous thread explained it best:

> We spoke about this at LPC.  And this is the correct behavioral change.
>
> The problem is there is a default value for i_uid and i_gid that is
> correct in the general case.  That default value is not corect for
> sysctl, because proc is weird.  As the sysctl permission check in
> test_perm are all against GLOBAL_ROOT_UID and GLOBAL_ROOT_GID we did not
> notice that i_uid and i_gid were being set wrong.
>
> So all this patch does is fix the default values i_uid and i_gid.

If my new commit message is still not conveying this clearly, feel
free to suggest the specific wording (I'm new to the kernel patch
process, and I might not be explaining the problems well enough).

>
>
> On Fri, Jul 05, 2019 at 06:30:21PM +0200, Radoslaw Burny wrote:
> > This also fixes a problem where, in a user namespace without root user
> > mapping, it is not possible to write to /proc/sys/kernel/shmmax.
>
> This does not explain why that should be possible and what impact this
> limitation has.

Writing to /proc/sys/kernel/shmmax allows setting a shared memory
limit for that container. Since this is usually a part of container's
initial configuration, one would expect that the container's owner /
creator is able to set the limit. Yet, due to the bug described here,
no process can write the container's shmmax if the container's user
namespace does not contain root mapping.

Using a container with no root mapping seems to be a rare case, but we
do use this configuration at Google, which is how I found the issue.
Also, we use a generic tool to configure the container limits, and the
inability to write any of them causes a hard failure.

>
> > The problem was introduced by the combination of the two commits:
> > * 81754357770ebd900801231e7bc8d151ddc00498: fs: Update
> >   i_[ug]id_(read|write) to translate relative to s_user_ns
> >     - this caused the kernel to write INVALID_[UG]ID to i_uid/i_gid
> >     members of /proc/sys inodes if a containing userns does not have
> >     entries for root in the uid/gid_map.
> This is 2014 commit merged as of v4.8.
>
> > * 0bd23d09b874e53bd1a2fe2296030aa2720d7b08: vfs: Don't modify inodes
> >   with a uid or gid unknown to the vfs
> >     - changed the kernel to prevent opens for write if the i_uid/i_gid
> >     field in the inode is invalid
>
> This is a 2016 commit merged as of v4.8 as well...
>
> So regardless of the dates of the commits, are you saying this is a
> regression you can confirm did not exist prior to v4.8? Did you test
> v4.7 to confirm?

I assume no one has noticed this issue before because it requires such
a specific combination of triggers.
Yes, I've tested this with older kernel versions. I've additionally
tested a 4.8 build with just 0aa2720d7b08 reverted, confirming that
the revert fixes the issue.

>
> > This commit fixes the issue by defaulting i_uid/i_gid to
> > GLOBAL_ROOT_UID/GID.
>
> Why is this right?

Quoting Eric: "the sysctl permission check in test_perm are all
against GLOBAL_ROOT_UID and GLOBAL_ROOT_GID".
The values in the inode are not even read during test_perm, but
logically, the inode belongs to the root of the namespace.

>
> > Note that these values are not used for /proc/sys
> > access checks, so the change does not otherwise affect /proc semantics.
> >
> > Tested: Used a repro program that creates a user namespace without any
> > mapping and stat'ed /proc/$PID/root/proc/sys/kernel/shmmax from outside.
> > Before the change, it shows the overflow uid, with the change it's 0.
>
> Why is the overflow uid bad for user experience? Did you test prior to
> v4.8, ie on v4.7 to confirm this is indeed a regression?
>
> You'd want then to also ammend in the commit log a Fixes:  tag with both
> commits listed. If this is a stable fix (criteria yet to be determined),
> then we'd need a stable tag.

The overflow is technically correct; the uid in the inode is invalid,
hence it must be displayed as overflow uid. The fact that the uid is
invalid is the issue.
Logically, this commit fixes 81754357770e (as that commit first
introduced invalid uid/gid values). If you agree, I'll add this to my
updated commit.

>
>   Luis
>
> > Signed-off-by: Radoslaw Burny <rburny@google.com>
> > ---
> > Changelog since v1:
> > - Updated the commit title and description.
> >
> >  fs/proc/proc_sysctl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index c74570736b24..36ad1b0d6259 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -499,6 +499,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
> >
> >       if (root->set_ownership)
> >               root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
> > +     else {
> > +             inode->i_uid = GLOBAL_ROOT_UID;
> > +             inode->i_gid = GLOBAL_ROOT_GID;
> > +     }
> >
> >       return inode;
> >  }
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >

--000000000000c732ef058cf67dd4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS5wYJKoZIhvcNAQcCoIIS2DCCEtQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBNMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWltZWNhMS5j
cnQwHQYDVR0OBBYEFNjckaVjv0usGyWog4fzEQDwvnfzMB8GA1UdIwQYMBaAFMs4ErDHmcB4koyz
IZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8v
d3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQB3vlS/wAdtf74qcz84
USBwIJlFJJ3DoveYUTjbiOS32IPsGJSPI6yZdKYBh05TPvu6ux6gi/QeZUDLybqywoTI/QFIjndu
E5435CtYtUDGcxzveTQGDabNFJ1pBfH8AmFKnb3R2Ck89f4rKXjrfWrnSnKOGy/UAvBjZWrU0qUW
Nr0Fi5znJGyWrE1gyOSQzsqK0rdK1nkOs3Dreh/EcM6FEjzOtWaXpzi+u/wqUkPC9F3YXlk0bIyE
mwsV4qBOh8iPtaR7MJxJDHnWWVkTE19zWhazWfAtI8KfhNZgtJ+2NlMRhoNDNVYH5qt34uBuGn/Z
P9hVEOfXyeNmoQI3H8ECMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIMZ/5mb433
UrpGY+hUMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCBlXTtwzY0o2ya7iflnwTf
mDa6x3VaDDGHiCBf5M8B2TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xOTA3MDUyMjE5NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglg
hkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAdQLeSTcpT/6xH5I1WjF8rwrOqO3ntuc/AVtYAA8o
/FKEQMXTay1R0kxcpvnVQjRFT7Ph6nVmzpPjr4uOu3yyyO12fyqP/vlVqFe2ultPu7bOtujRFVL1
i28YNXg3kOvZUonyyZejR2cjyRD6tnkZALLOh/AxcI9mRkWzUQqgre57Ev9N7qGcc4UhkteRpUBw
vYD11DOJmer4083ENVzuxBFsng00eqgMZMlS4PvGGDUPWP84qqTzU/+/GGIDRg8SNIM1B3Q6s4TT
thc+FPOLKNVWXCf5Z+dWBxuVD2JFNBGW9QqJ8NLIzAjSt/8r35WaIQ6oa4lLd3XjaapYpKlxug==
--000000000000c732ef058cf67dd4--
