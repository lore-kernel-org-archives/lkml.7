Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0857C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8005D21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCpqiOYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfDQNc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:32:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42024 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQNc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:32:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so12108002pfi.9;
        Wed, 17 Apr 2019 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dZRFc3P8uGOzh5Zz0BAB3HoSOPuInYM2ESa0V7ViyQY=;
        b=UCpqiOYx54c7YvwCXfVD7JWl5Rl6kNOuPZIsXEN+DC6WO2Wzewf+N2uqXb+9CB9zb8
         zpFXxWGS0rRVg58GHKswuloXZrH5MDhqyDqFVjk1AwGV5Ep1fQ7HitCWCEtwWj0uzFmX
         PjL7ywtYjfMKt09QnbI5nbOlRX0AjhgMpT/rcDpEhlmAtPryI90To6Lz9w65UvtOWuuw
         HChgyPI3EKHuOt8hkpjFn4IPJm/PRDM1TUQWhfK8m5OYvO4e/zyj0iiLI4JZEGeSyM1g
         U7chLorkDSpJYmtiUjeKrQiZlWPL4/9GyUSHD9wru8YgtHjwhSPcxM7QhV5r49oGrh0f
         1ZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dZRFc3P8uGOzh5Zz0BAB3HoSOPuInYM2ESa0V7ViyQY=;
        b=o4dzmZmuaYu38Vag0AF+N2WpPmgG+jHYbehkBrC6XUIz4GNvdAlp0crKBrCKwkbzCf
         zAzc7sl29B35pcz974u2ifq6IEZdIFWBOEvYTur1KaCKGWHXMhPC6Fmzi+jJrJlWlERQ
         BAXBX2VbvNENrrL2EBgfoBllhZGL1vPn7+84rVgKEUZX4YQOzApwO2NeTjaFR/EN3/9K
         3a/A1Erw3Ely9MPlA69TkqiGGW9ZVtXavIWpP4++LRZEMxZribr0R/DBCmtGpZHJ/156
         seKsPxIjk5HiF+XyA01Hgq9PgxiGiwvCMcslGpl5OBTvsBC+YW8Lu9Li8rymu6qQo+fJ
         12oQ==
X-Gm-Message-State: APjAAAXygoRZ+Lwc33WRT/bgfjXb2i44WU2vWigQ3MYxW3KBzLp8x8z/
        2iFg5Hyk/QE1g4Ws8wbxCvn0vyyUM7si3gEtF4sY3qrC
X-Google-Smtp-Source: APXvYqz3yDZrzdyKMfbfnfO/up3f/vrblOubvd2vUDRCZpfI0E55KSjRh1Ctwnh980090LIlzfVAfj2JR6LU8IxjROw=
X-Received: by 2002:a63:8ac4:: with SMTP id y187mr36712005pgd.13.1555507945926;
 Wed, 17 Apr 2019 06:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <CANtEx+B4_-7Kfq6Gur1xHcXnTYRq8ZN=Qqs2X=h-ZJuFFF7LbQ@mail.gmail.com>
 <19402.1555487793@turing-police>
In-Reply-To: <19402.1555487793@turing-police>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 17 Apr 2019 08:32:12 -0500
Message-ID: <CAH2r5mvON=nCftcqcb4znhdOYR8XHcCKJseorWvzUVhG7oa8CQ@mail.gmail.com>
Subject: Re: Need advice about do we need this if condition
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     B1C0D8C0 AACEC2D2D3CDC5CDCACE <alexander198961@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        kernelnewbies@kernelnewbies.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 2:59 AM Valdis Kl=C4=93tnieks
<valdis.kletnieks@vt.edu> wrote:
>
> On Wed, 17 Apr 2019 08:25:22 +0300
>
> (Adding Al Viro and the linux-fsdevel lists, as at the very least, the ma=
npage
> for the syscall needs some clarification...)
>
> > hello I am trying to fix https://bugzilla.kernel.org/show_bug.cgi?id=3D=
202935
>
> So - convince us that it's in fact a "bug" and not a restriction.
>
> > I found cause
> > https://github.com/torvalds/linux/blob/master/fs/cifs/cifsfs.c#L1076 no=
t
> > sure is it correct to remove such condition ?
>
> Does the CIFS protocol support copying from a file to another location in=
 the
> same file? Was it intended to work on *any* filesystem?

Looks like it should be allowed on the same file as long as the source
and target file ranges do not overlap

See https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-fscc/1e=
e611b7-43f0-468c-8a9d-28f04cdc3376
section 2.3.7.2 and 2.3.8
Server returns STATUS_NOT_SUPPORTED if "The source and target
destination ranges overlap on the same file."

and line 112 and following of smb2_ioctl_filesys.c in Samba code

https://git.samba.org/?p=3Dsamba.git;a=3Dblob;f=3Dsource3/smbd/smb2_ioctl_f=
ilesys.c;h=3D8a9c8c64ec9ddbca4623251555f4792d76aa6e44;hb=3Drefs/heads/maste=
r#l112

> (For that matter, the manpage for the syscall is unclear on whether havin=
g both
> file descriptors open on the same file is OK or not - for bonus ambiguity
> points, there's exactly zero discussion of what happens if source and
> destination overlap destructively).
>


--=20
Thanks,

Steve
