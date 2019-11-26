Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04635C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55B42071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574739594;
	bh=zttIXbRX7l+l8M4GLvb3lfIKrwJFdLoiUKEWBlJBXxI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zX4ACFwL37vOHQJePHUfFSzCdfDYcP98I3Pdnxn6bNkNxaQebkJX2Dr1pSavnl/2i
	 T52lL8gw06t34yCF/+vV/nv9glhva1HZdKSSULwmilfDwgalyYmvZB6LT8iCK4SSGs
	 RLjtImn6WFtXxF23HDf8KBoq8KMHLCj6gGNp7zjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKZDjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 22:39:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42922 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKZDjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:39:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id n5so18402082ljc.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 19:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7kSELiwQPVUVLBtAiDV/N9MMfelmgWcqQJspxuvoAk=;
        b=h/SHjeuM08FRQWIVBFXjBZvHeODdnljS4jKWnUiYTccKUOBSJjlJ6yN/5auVjb3G7U
         a73XRYCtGMBdGPUbWlA68ClSvBBVx0oaJv/AdS20cBNiTVmTD6g5Ywl5qDYZCDn6Uvdj
         bpM7kL/1wCh5NrDSw5ksjKVsbwNczjaOkN614=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7kSELiwQPVUVLBtAiDV/N9MMfelmgWcqQJspxuvoAk=;
        b=qIvRquX+PJBBFPu4aey6x7UeLq14cdbwMce9JJnFJVe4dpQLSOBL74wGEnav06p6n1
         Ocu4zl51kW5jHWUF11jUNCJG+NjhiYMKqt6GGIRMoEisurAIAVbQcySSqF7uA7xNRpjl
         loZPC3Alzh1M5HHpyUbO3SMHnWsXXc5U/psYUM2pfGOQzhWQMjxUEO3d/WQpyvDR7Cxe
         DccgTwHAFJx9sMRoNFt2ye8ChZ04MHRGiFQ0Ubc7Alw4bo1pQ1Y/5U67i+msaPpTQ/Gl
         l7zFK9EWU3SQrnMUT4uyW9vIGy6Xyl+8I87trUX3KVPbJZ4nFQO7PSBK9i6F7ZALOWIN
         GdTg==
X-Gm-Message-State: APjAAAVkFeL5EdSZHyb/gL+XWTy1Ok03ksFel54ftgO66yoW/ZAh0Mjj
        BdXY800URyYoe8cCC9dRnj9IPG1ml9A=
X-Google-Smtp-Source: APXvYqw3qeRLJCsADlqsPLf5mRWUFj2RfwHowiK4gOXKk19rThx7NPVq0CfPnWfeQmsjlneHZDjzHw==
X-Received: by 2002:a2e:9d8d:: with SMTP id c13mr22194766ljj.71.1574739591037;
        Mon, 25 Nov 2019 19:39:51 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id b190sm4497300lfd.39.2019.11.25.19.39.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 19:39:50 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id e9so18393383ljp.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 19:39:50 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr11101925ljj.97.1574739589877;
 Mon, 25 Nov 2019 19:39:49 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911251322160.2408@hp-x360n> <CAHk-=wj_nbDN3piDJBEteUrjyrZCTA+CCk15NfV=5D2xFfGJGw@mail.gmail.com>
 <CAHk-=whn2Dp44tjUpLo9ogs=p-v-Vn7c2Xdo4p+2V=d1hTaiuA@mail.gmail.com> <CAHk-=wj3YSFT+C3n=7CTsB-8U0NUpTpT3xEH866H4-1qbQGw7Q@mail.gmail.com>
In-Reply-To: <CAHk-=wj3YSFT+C3n=7CTsB-8U0NUpTpT3xEH866H4-1qbQGw7Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Nov 2019 19:39:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYSnvfZNN1_Nr-S5C+a8-SkSMZO4Rf3NDAO046+rTNXQ@mail.gmail.com>
Message-ID: <CAHk-=whYSnvfZNN1_Nr-S5C+a8-SkSMZO4Rf3NDAO046+rTNXQ@mail.gmail.com>
Subject: Re: Commit 0be0ee71 ("fs: properly and reliably lock f_pos in
 fdget_pos()") breaking userspace
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 7:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Of course, this may fix the f_pos locking issue, but replace it with a
> "oops, the character device driver tried to look at *pos anyway", and
> that will give you a nice OOPS instead.

Confirmed. At least the x86 firmware update code uses
"simple_read_from_buffer()", which does use the file position, but
doesn't actually allow llseek().

So no, "it's a character device no llseek" does not mean that it acts
as a pure streaming device with no file position, and we'd actually
have to mark individual drivers (either by adding 'stream_open()' in
their open routines, or adding the extra field to 'struct
file_operations' that I mentioned).

I think I'll have to revert that trial commit. I'll give it another
day in case somebody has a better idea, but it looks like it's too
early to do that nice cleanup as things are now.

              Linus
