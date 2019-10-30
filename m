Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1703DC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF342173E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572432898;
	bh=9dXBQTNelP7YGh565AlkMr+9JlOxUXuYZ+QCaMPcqbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yo9JsrhB2WBgEsmpB8ldj9CvU0seWrQZv2cBLt2fZ9PJZhlntgD29QDGWn2QlKNB1
	 rmj21yeegsmMekwTRnsCApLaiKRfZSc+zq292Qvku7EPxocROtz65O/DVWSjxphYG2
	 xXmpSfnV+82SBAECGh6BkIXXJCQm2PwSWqR08HXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfJ3Ky4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:54:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40984 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfJ3Ky4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:54:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id m9so2106532ljh.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtCKRSOH2wHBPxYWft32/SnJnhtK6FCm3n3b1weS2iw=;
        b=BAJsYTc/WnEx9YqK3Q0ZjZ4NLIwdz+jXTH4YfRpJ9sI9RvhB5+3oEy4JGzzu9ikMmj
         JBFxfCmjslc2gcgXJ8TUmf3+BQRpjtIMcUHEHm10Dbx9leMzPLpvUiu9ddeV3+iQwLbO
         aVM+FYR1044gIW56sLGDszs2pmd8cDBgBBeXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtCKRSOH2wHBPxYWft32/SnJnhtK6FCm3n3b1weS2iw=;
        b=YZ4HhA+GbmDngCL8w/uLUWCQTNfMAVJfrNz/uiY25yeDGD8MZUTDFLgx9uY1yXIUET
         Rl5BkScGAkC/jPf/d+QIlWLiOFexmedPMkLm8cdxaESvh8nmdZrAr1TDjOik7+wfsaIC
         pH0Kws74sM0gSRj9Yh6O1k31yYJ3heEa/DZluLUwxOnLJx7UqygBr+53Uu++SOs0kEc5
         NFrgaZbrsvKlk3wEpUB8e+4NIQ9vp9clqo84n7E/c86nT0lGPYyDRVesZzmE4o8+kaFI
         KOfHQr7yId2dzC9NILpfthmV/x+PlSCghKTk1u6yYhL3UCsyRaPRfo9/ZKo+9xpvvb6K
         YRPQ==
X-Gm-Message-State: APjAAAUF2D7LUqjNNZODzEEseYQCqrhCZm8mpHi8+VBBLDjNM/+Df2gW
        L9ye53DfplyPdyvP2O9XwDIuJWLCyfYG8w==
X-Google-Smtp-Source: APXvYqxbb/rFTVK+0AJknG+vSWy4LLQHxjpYfMYwdiP0oBQt3Ay6zaSxgbb9Ra8qnjkX2Ok+xxsZeQ==
X-Received: by 2002:a2e:9782:: with SMTP id y2mr6285264lji.46.1572432893680;
        Wed, 30 Oct 2019 03:54:53 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k10sm802694lfo.76.2019.10.30.03.54.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 03:54:52 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id j14so1176412lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 03:54:52 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr5783119lfc.79.1572432891872;
 Wed, 30 Oct 2019 03:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box> <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box> <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com> <f0140b13-cca2-af9e-eb4b-82eda134eb8f@redhat.com>
In-Reply-To: <f0140b13-cca2-af9e-eb4b-82eda134eb8f@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Oct 2019 11:54:35 +0100
X-Gmail-Original-Message-ID: <CAHk-=wh4SKRxKQf5LawRMSijtjRVQevaFioBK+tOZAVPt7ek0Q@mail.gmail.com>
Message-ID: <CAHk-=wh4SKRxKQf5LawRMSijtjRVQevaFioBK+tOZAVPt7ek0Q@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:35 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> NFS may be ok here, but it will break GFS2. There may be others too...
> OCFS2 is likely one. Not sure about CIFS either. Does it really matter
> that we might occasionally allocate a page and then free it again?

Why are gfs2 and cifs doing things wrong?

"readpage()" is not for synchrionizing metadata. Never has been. You
shouldn't treat it that way, and you shouldn't then make excuses for
filesystems that treat it that way.

Look at mmap, for example. It will do the SIGBUS handling before
calling readpage(). Same goes for the copyfile code. A filesystem that
thinks "I will update size at readpage" is already fundamentally
buggy.

We do _recheck_ the inode size under the page lock, but that's to
handle the races with truncate etc.

            Linus
