Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35638C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0095920643
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iTeGmX2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfDII3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:29:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfDII3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y1HDoDQnsl8sbo50kYmfppzR+tj1me3IOOYaXhN8kEg=; b=iTeGmX2ziQti9SNDx5xTROiCT
        xM0ZR40GSQJ0roghqy6zD5Z1yA3j8OYxRWBacmd2FnlcbkjyciPyk0xMtB8GnOXFfM6yQpDnOUdV7
        BdH6pMavKTaj+lmMvZPPHam+huG8xzaQ1XabZiIZwrQWDDkvB8Z1b3sd16r8a/2LSJHxQA92Ny5aI
        YQYvn1yOPpVTOOYDWwAejWbKtU34tlNNgSowMXN2i2Fc7s/U8NJpIq+h0vIa3KPdptolMwb4ZsaBN
        SIapCLe5OPA7UVQbhQ4XS/M0dJtqL2A0k4CKxzobVvARKvIDgfxvl9rPsoTMlfgvOCIK4GyUTuOn7
        5PrOS8csg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDm8b-0008A4-MK; Tue, 09 Apr 2019 08:29:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5647C2030C779; Tue,  9 Apr 2019 10:29:47 +0200 (CEST)
Date:   Tue, 9 Apr 2019 10:29:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>, acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        mark.rutland@arm.com, jolsa@redhat.com
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
Message-ID: <20190409082947.GN4038@hirez.programming.kicks-ass.net>
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
 <20190403104103.GE4038@hirez.programming.kicks-ass.net>
 <eb3cbf9b-6851-72c6-2648-3e6eaa78fb7d@linux.ibm.com>
 <20190404110909.GY4038@hirez.programming.kicks-ass.net>
 <20190404130300.GF14281@hirez.programming.kicks-ass.net>
 <adcbac67-82b5-98a4-efb4-61c9ed870c15@linux.ibm.com>
 <20190408082229.GI4038@hirez.programming.kicks-ass.net>
 <20190408095031.GG14281@hirez.programming.kicks-ass.net>
 <d647a482-f3df-bb0a-3a02-2fecb51b3238@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d647a482-f3df-bb0a-3a02-2fecb51b3238@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 08:07:49AM +0200, Thomas-Mich Richter wrote:
> On 4/8/19 11:50 AM, Peter Zijlstra wrote:
> > On Mon, Apr 08, 2019 at 10:22:29AM +0200, Peter Zijlstra wrote:
> >> On Mon, Apr 08, 2019 at 09:12:28AM +0200, Thomas-Mich Richter wrote:
> > 
> >>> very good news, your fix ran over the weekend without any hit!!!
> >>>
> >>> Thanks very much for your help. Do you submit this patch to the kernel mailing list?
> >>
> >> Most excellent, let me go write a Changelog.
> > 
> > Hi Thomas, find below.
> > 
> > Sadly, while writing the Changelog I ended up with a 'completely'
> > differet patch again, could I bother you to test this one too?
> > 
> 
> Hi Peter,
> 
> I verified your second patch, it ran overnight without any message in the
> kernel log. Thanks again.
> 
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Most excellent, thanks for that!

