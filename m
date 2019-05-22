Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C9BC072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29F521841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC0XTrKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfEVA3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 20:29:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33804 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfEVA3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 20:29:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id t64so211020qkh.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 17:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L39lzAr5bcvmMCGfBSkVAobh5PBuvDAZo/1mKAtyt4I=;
        b=fC0XTrKIzChfNuyR/FbSvQtf34gjMnDIHJnxuNdzHGA9/DdXznx2AERKAAwLIVH8Oe
         0HOpCPEdWX0d5cK6cxgkMpHb4Okh3kzgolg4duAFp9Ah5e7ASysswnxkiTdNxI372EBt
         gMr5qstgfL5ICd5NC1si1oQYo8F6YIRmLK5rKaglBnPY1P8eMrQzBEnrFMWZihqWVsbB
         GERUizNmHWC0aH8YgypJBBMAtSyQz9dw1Ptx/dxeaxja16fTyX9tCL24YmeR9YVb1pgS
         4GPGxhQIGUXm4jW94OQ+d1tD0A3+iRRbEPdxLuFkwCHuH1+QnaKe4ZtIIgxZk5Kkyxs8
         qzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L39lzAr5bcvmMCGfBSkVAobh5PBuvDAZo/1mKAtyt4I=;
        b=Uglx58ipl1hyzuMi//lbTVSlBe0ByCijQWTJ6sCf+qyYsjrxKNevDX1uMCpaUl7mtX
         tVNL40Lj9gcafwJkNQRK1fYH7nU9QqHwt3nHIAPsjIYaKjaDYstD9nholaHqbnAQeXy1
         f8LeB6zrtsSST1kVANC0WwNKtrHpcikI1yoiGTcmtcF4kj72vkexKgObZKI7ZIzQM39T
         Xwbx/4kubU0vErlXdFVnv4R9LeZkcHhsKy1oDPfSxnjBmbNtI3P6da8N+UvzUACN3Iit
         7DeVzu3ExAU0fS7lfkcbsgu1x8boZ0ZbH3G1SyosY5G2L0mvw+0yqZ88XFgx8sO718Gz
         Ktdw==
X-Gm-Message-State: APjAAAV6CoeyPDVcolCo9FxAGjyZt/UDueNWLGjTEZwwLUxPfYLnHmTj
        2cisW9PacrDKKnntLmPhujY=
X-Google-Smtp-Source: APXvYqw8i84IhZJvkcv9cgYV8R7lS9InkS7DZ+Hp+7nJtI008kI2s06bl4G4Lh9HXTJlUIBjJu+0Ow==
X-Received: by 2002:a37:6d03:: with SMTP id i3mr68159655qkc.112.1558484990780;
        Tue, 21 May 2019 17:29:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id t17sm14194608qte.66.2019.05.21.17.29.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 17:29:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36F7B404A1; Tue, 21 May 2019 21:29:45 -0300 (-03)
Date:   Tue, 21 May 2019 21:29:45 -0300
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl when system kernel headers
 are ahead of the kernel
Message-ID: <20190522002945.GF26253@kernel.org>
References: <20190521030203.1447-1-vt@altlinux.org>
 <20190521132838.GB26253@kernel.org>
 <alpine.LRH.2.20.1905211632300.4243@Diego>
 <20190521151918.GD26253@kernel.org>
 <20190521180354.GE26253@kernel.org>
 <20190521205322.pasqqgpaaxjx7buy@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521205322.pasqqgpaaxjx7buy@altlinux.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 21, 2019 at 11:53:23PM +0300, Vitaly Chikunov escreveu:
> Arnaldo,
> 
> On Tue, May 21, 2019 at 03:03:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, May 21, 2019 at 12:19:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, May 21, 2019 at 04:34:47PM +0200, Michael Petlan escreveu:
> > > > On Tue, 21 May 2019, Arnaldo Carvalho de Melo wrote:
> > > > > Em Tue, May 21, 2019 at 06:02:03AM +0300, Vitaly Chikunov escreveu:
> > > > > > When a host system has kernel headers that are newer than a compiling
> > > > > > kernel, mksyscalltbl fails with errors such as:
> > 
> > > > > >   <stdin>: In function 'main':
> > > > > >   <stdin>:271:44: error: '__NR_kexec_file_load' undeclared (first use in this function)
> > > > > >   <stdin>:271:44: note: each undeclared identifier is reported only once for each function it appears in
> > > > > >   <stdin>:272:46: error: '__NR_pidfd_send_signal' undeclared (first use in this function)
> > > > > >   <stdin>:273:43: error: '__NR_io_uring_setup' undeclared (first use in this function)
> > > > > >   <stdin>:274:43: error: '__NR_io_uring_enter' undeclared (first use in this function)
> > > > > >   <stdin>:275:46: error: '__NR_io_uring_register' undeclared (first use in this function)
> > > > > >   tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: line 48: /tmp/create-table-xvUQdD: Permission denied
> > 
> > > > > > mksyscalltbl is compiled with default host includes, but run with
> > 
> > > > > It shouldn't :-\ So with this you're making it use the ones shipped in
> > > > > tools/include? Good, I'll test it, thanks!
> > 
> > > > I've hit the issue too, this patch fixes it for me.
> > > > Tested.
> > 
> > > Thanks, I'll add your Tested-by, appreciated.
> > 
> > Was this in a cross-build environment? Native?
> 
> It was native build on aarch64 with both 'hostcc' and 'gcc' arguments of
> mksyscalltbl being set to gcc.
> 
> > I'm asking because I test
> > this on several cross build environments, like on ubuntu 19.04 cross
> > building to aarch64:
> > ... 
> > I.e. it didn't fail the build, but in the end these new syscalls are not
> > there, while with your patch, they are:
> 
> Probably in your case system headers was older than kernel you are

Yeah, that seems to have been the case, thanks for your patch...

> building so you just silently losing syscalls.

... now we're not losing them anymore, as intended from day one :-)

Thanks again!
 
> > Thanks, applied.
> 
> Thanks!
> 
> > 
> > - Arnaldo

-- 

- Arnaldo
