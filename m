Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362C6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F386D2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTKRfUPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCMO1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:27:08 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40658 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMO1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:27:07 -0400
Received: by mail-yw1-f67.google.com with SMTP id u70so1580645ywf.7;
        Wed, 13 Mar 2019 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WzssSWiIpBhFCg7dDWCZzQb3cazuLKAR34HpPN5C/tw=;
        b=GTKRfUPpH56z7AW66nUJBdDbaMtKMDlGxscsSTNQ1YBT4VYOFE4Y+FAY93lcpuM7/Q
         74cwqIaAlSPU5FepszxR2tQk8Gk3BLUjRAZsIeeCDSIsA+3kxbGUKVRLM37Bt3TA9+d1
         fvUn6t/i9Y6vlpSbWfCKjWoxrwVzAqKDUX0Eit4orjWCdRi8LiXTJx1rkjrSsW4YB/CQ
         mHp53nR2VCUu4L6uS1dABJj4+8QwzYvWei6hpW6XrNPB8I4P1eGdD7pS6/5pqWu2Ec5g
         mTUixqmjp3kQhXk36FgvcUkxAjL3YmTB9L6H4DKx3UA/7u5jC8CiV8lbEDYJa+quDEWy
         AKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WzssSWiIpBhFCg7dDWCZzQb3cazuLKAR34HpPN5C/tw=;
        b=GHY4YMusyl5W+RMC2wb7yqiQ7pgzECjtu6bTBr9QsUu9GpugzkrR0UltRCDNJb2jNI
         g1GOb6D8nNpYC2lppUig4kj2W2cFhplzyPG5zenNSv7sjUK0JQesstRfPmTMd2HFX9fz
         aNuwqRsLvq9d5XBk6hNBb9fEuDQE4bSvauARsi2rd3SwpADvBqdzlKScfCqXyuIRCAAh
         INn1XGb6OJbBVDeNTgNYq+xc/2pYgn4/dXltAS2DT74TFjV1a79mywzj2v9gwhWKcbPb
         zdtX/1kLmTCd4Rm9WEqwsvgq1EOrYLAF2niKpJH1O0uIONVFVZy+Vw7ZxWPxBiqVlUmk
         mJ+Q==
X-Gm-Message-State: APjAAAW7y/AMJM/ID7GmBL6GhCE4pBlARrLRTcr0h2fFRBuaa8b6dxdE
        fMLsAD4keEg73gAgx24DP2UV/Bp6LxH6B2SD/yo=
X-Google-Smtp-Source: APXvYqzQY0abGCYaKgvCwX5jJU1vnJl2wL/xcqc5kyXp1+fg7LxIOrnlpOwh1XPT/0vcodACGLJ+5C444+utYbmllmw=
X-Received: by 2002:a25:5046:: with SMTP id e67mr38102029ybb.397.1552487225985;
 Wed, 13 Mar 2019 07:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <4603533.ZIfxmiEf7K@blindfold> <1854703.ve7plDhYWt@blindfold>
 <CAJfpegtgfuAkgv26QH6Ht25OeMiev-QvEf7ror4KAbud7FADgg@mail.gmail.com> <4066872.KGdO14EQMx@blindfold>
In-Reply-To: <4066872.KGdO14EQMx@blindfold>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Mar 2019 16:26:54 +0200
Message-ID: <CAOQ4uxhqQKzriL0An4Tvzc1E_LffL-z9q1otOW_RdD1ZdKWP3Q@mail.gmail.com>
Subject: Re: overlayfs vs. fscrypt
To:     Richard Weinberger <richard@nod.at>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 3:34 PM Richard Weinberger <richard@nod.at> wrote:
>
> Am Mittwoch, 13. M=C3=A4rz 2019, 14:24:47 CET schrieb Miklos Szeredi:
> > > The use case is that you can delete these files if the DAC/MAC permis=
sions allow it.
> > > Just like on NTFS. If a user encrypts files, the admin cannot read th=
em but can
> > > remove them if the user is gone or loses the key.
> >
> > There's the underlying filesystem view where admin can delete files,
> > etc.   And there's the fscrypt layer stacked on top of the underlying
> > fs, which en/decrypts files *in case the user has the key*.  What if
> > one user has a key, but the other one doesn't?  Will d_revalidate
> > constantly switch the set of dentries between the encrypted filenames
> > and the decrypted ones?  Sounds crazy.  And the fact that NTFS does
> > this doesn't make it any less crazy...
>
> Well, I didn't come up with this feature. :-)
>
> If one user has the key and the other not, a classic multi-user
> system, then you need to make sure that the affected fscrypt instances
> are not visible by both.
> For example by using mount namespaces to make sure that user a can only
> see /home/foo and user b only /home/bar.
> Or removing the search permission on /home/foo and /home/bar.
>
> I know, I know, but that's how it is...
> Maybe Ted or Eric can give more details on why they chose this approach.
>

AFAIK, this feature was born to tailor Android's file based encryption.
https://source.android.com/security/encryption#file-based
It is meant to protect data at rest and what happens when user enters
the screen lock password IIRC, is that some service will get restarted.
IOW, there should NOT be any processes in Android accessing the
encrypted user data folders with and without the key simultaneously.
Also, like OpenWRT, in Android the key does not get removed
(until boot) AFAIK(?).

That dcache behavior remind me of the proposal to make case
insensitive a per mount option (also for an Android use case).
Eventually, that was replaced with per directory flag, which plays
much better with dache.

IMO, the best thing for UBIFS to do would be to modify fscrypt to support
opting out of the revalidate behavior, IWO, sanitize your hack to an API.

It's good that you are thinking about what will happen with overlayfs
over ext4/f2fs, but I think that it will be messy if dentry names would be
changing in underlying fs and the fact the overlayfs accessed the underlyin=
g
dirs with different credentials at times makes this even more messy.

The way out of this mess IMO would be for ext4/f2fs to also conditionally
opt-out of d_revalidate behavior at mount time if the fs is expected to be
used under overlayfs.
In Android, for example, I think the use case of "admin deleting
the encrypted directories" is only relevant on "reset to default" and that
happens in recovery boot that could potentially opt-out of encryption
altogether (because there is no user to enter the password anyway).

I could be over simplifying things for the Android use case and my
information could be severely out dated.
CC Paul Lawrence to fill in my Android knowledge gaps.

Thanks,
Amir.
