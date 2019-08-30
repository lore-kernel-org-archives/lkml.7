Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F0AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEBE23427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567175433;
	bh=Y6c1VZRDxo3ZvyTBYnqdXsSA+tvNWJORJuqsrlFhlnE=;
	h=Date:From:To:Subject:List-ID:From;
	b=peTfsjdbE/ZgdZPeMztgDgNz2VwcWI/XUmmptxqyBgGu0XSu34VBvOF6YZtEUM0sK
	 BHjfUcYzDqEBG7jkE+JY/JsuD5i0IA103eThlbxBCgJZp4L/H3HAcnclMO+q0cv0qC
	 +UsPH2NrSlA0OMv21P8nt+bkpytT0D/fZvJwQwhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfH3Oac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:30:32 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:45491 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfH3Oac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:30:32 -0400
Received: by mail-qt1-f170.google.com with SMTP id r15so2123457qtn.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UxY0w7YqN8BkEuPZBgrNQAb+VFkKgfzjECjLI7NtGIY=;
        b=aah7XevNwk/yCFgFJzW4cG5rGFE2/xajeoY3ldJ0iFyWpTDD8SGANYbYyz6Oaf2HP0
         Im+Rf4Ai/LkCfvm+G/cwF0LQuXU5UcjfcbgK8GkUQpc+PA73cG+TQh2F6Bfoxvlv31Wx
         +sOwuW5CRCMcteFxL2IGLFQ8NbF+4UwrgPcqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UxY0w7YqN8BkEuPZBgrNQAb+VFkKgfzjECjLI7NtGIY=;
        b=uesj3Zx0zsca25svwANHTMBao1HaGLgHofTKIq2AO4r93Ce6Yt7sEMOgmjLJV8z9Qt
         tTe3gXC/qzDctFFbpVv4llD85g5t1DpDlqLsWlTr7HQ1fYo8Vk7Ku7Xq3LCgdL5Tz+Tn
         rhXJXMjbMJ1DHVXg0iIQDfaPsRCC7QzjAujQtupBn2H8k0FAhMDtILMzLiiFxTsUnJfH
         +N/Me1MEAlfC8v6wSYxeBr1DRkfX4dWmH7bMaJFuuH4HKkVPWeK+nbbJmqwU3gFVzG5b
         NEXZK9tWaQn/dF/g00Lz1VVgQhOGVogalAPZTky7UzkyRVM7eYuTrS5HwR72xtlb8Bt+
         f1Yg==
X-Gm-Message-State: APjAAAX9gSVMpVzWuCm77i57K40tqMiMbHx2xqpQy1NqQ9VlE6VFpU38
        M/e7Mo6iMCGFv4zYKpmUOfcWL/2vjt8=
X-Google-Smtp-Source: APXvYqwwJUwvX08jRXpcwPuFMW0XOyIniGDEb2FYA6LuJkFFVWuZfJDPsI4Vh0qvnEEl/qA82vIe9g==
X-Received: by 2002:ac8:748a:: with SMTP id v10mr15623580qtq.386.1567175430073;
        Fri, 30 Aug 2019 07:30:30 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id u23sm1052895qte.36.2019.08.30.07.30.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 07:30:29 -0700 (PDT)
Date:   Fri, 30 Aug 2019 10:30:27 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Subject: Distributing kernel developer PGP keys via pgpkeys.git
Message-ID: <20190830143027.cffqda2vzggrtiko@chatter.i7.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d433sdinoctmgvmm"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d433sdinoctmgvmm
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, all:

As you may be aware, the SKS keyserver network has been very unreliable=20
lately due to two general factors:

- a large number of SKS servers were shut down in the past year or so=20
  due to GDPR compliance concerns (as designed, SKS is not compliant and=20
  cannot be made compliant)
- the recent signature poisoning attack generated general distrust of=20
  the keyserver network, so people have been avoiding submitting key=20
  updates to the keyservers, resulting in keyserver data becoming=20
  increasingly stale
- the web of trust concept is seen as an obsolete concept because it=20
  doesn't scale to the whole of the internet, so there is little=20
  motivation for anyone to fix the keyserver problem

This has caused an issue for the kernel development community, since=20
many do rely on the PGP web of trust when performing such actions like=20
checking PGP signatures on git tags found in pull requests. A=20
significant number of developers have also been increasingly relying on=20
kernel.org to maintain the Web Key Directory (WKD), which now acts as a=20
certifying authority.

Unfortunately, if we abandon the web of trust completely, we will have=20
to go back to relying on kernel.org infrastructure as the source of=20
trust. Kernel.org has been hacked in the past -- ever since then our=20
goal has always been to keep developers as the sole and only source of=20
truth. This requirement is why we cannot and should not abandon the=20
developer web of trust and must keep it going, at least in parallel to=20
the WKD and similar efforts.

I've investigated a bunch of keyserver/key distribution options=20
available today and none of the current ones offer what we need to do:

- SKS: hasn't been maintained in 15+ years, isn't and cannot be made
  GDPR-compliant, is written in a quaint implementation of OCaml, and is=20
  vulnerable to DoS attacks via signature poisoning.
- Hagrid (keys.openpgp.org): strips 3rd-party signatures, so cannot be=20
  used for WoT purposes (also, it requires a Rust nightly build to run).
- Web Key Submission (WKS): strips both 3rd-party signatures and any=20
  UIDs that aren't @kernel.org -- so while we will offer it as a way to=20
  publish key updates, it is neither sufficient for Linux development=20
  (not all developers have kernel.org accounts), nor is useful for WoT=20
  maintenance purposes.

So, we are going to do something similar to Debian's keyring package --=20
I will maintain a git repository of developer keys and everyone=20
interested will be able to pull and refresh from that repository.

Here's what is already done:

- the repository is available here:=20
  https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
- it provides both .asc exports of individual keys and handy graphs to=20
  see each key's trust paths to Linus (done with wotmate, see=20
  https://git.kernel.org/pub/scm/utils/korg/wotmate.git)
- it additionally provides a korg-refresh-keys script that can be run=20
  either manually or from cron to automatically refresh updated keys
- any 3rd-party signatures from keys not present in the repo are=20
  stripped during export
- to submit key updates, send an ascii-armoured key export to=20
  keys@linux.kernel.org, which is currently processed manually, but=20
  we'll be adding automation to streamline the process
- the keys submission archive is available on=20
  https://lore.kernel.org/keys/ for historical purposes
- see the README.rst file for more info on these topics:
  https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/README.rst

Here's what is left to be done:

- add automation around keys@linux.kernel.org to add pre-validation via=20
  one of the key's UIDs (e.g. via requiring a valid signature of a=20
  specific nonce)
- add automatic notifications of key expiry with instructions of how to=20
  extend expiry dates and resubmit
- add automatic tracking of additions to the MAINTAINERS file so new=20
  people can be auto-spammed to send their keys to keys@linux.kernel.org

As you can see, this project is still young, so if you have any=20
improvement recommendations, please feel free to let me know.

Best regards,
-K

--d433sdinoctmgvmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCXWkzAQAKCRC2xBzjVmSZ
bL0OAP4uEEF1JWWmjTgedDCVh8f1VDapdqZ+fTQj+5o5HPdtSgEA12++Ekwj1X3T
5F2MnwKV42n+P+odt4uqbCx0hkMbsAc=
=qr9m
-----END PGP SIGNATURE-----

--d433sdinoctmgvmm--
