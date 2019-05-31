Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E7CC28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44E7264DD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="jZWrssK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfEaHAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:00:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41677 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaHAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:00:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id x25so807416eds.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 00:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7A86gT5ZbQGdEaQPTXTX362/h2RCatTQByTt+5Bm06w=;
        b=jZWrssK4m8KO9SfE4seS+D6HRtswXAVNT4nI+9zN8mxexOUmabIaw+4QoejvYmvigV
         G2cap7wbZTuOvQB9hLXRtG9NLIMuckuFnu9GVKtlD3dBP2al4lQGtxRDV9WTMvf1BwnT
         8wf4REbcTOJDsSeNoItEOzTtQGfOT2tZbKMSGDv8oZ8NPXuWDXgcNB8lbvM2JS045Lca
         UPVh00IeZ3JbY9iCQYeNQgUyfjcFZ33frXk+D82lcyKCkiiIPOMHQnU2owx4o9BxwkJX
         s2hI+sTateQXokSKni8Pyz/QAU2wcCRtFcSlUIc4R2O8OPCYU3T0ob3l9ji3QGGzYFjV
         qpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7A86gT5ZbQGdEaQPTXTX362/h2RCatTQByTt+5Bm06w=;
        b=m16i69wURojp308IviT+ReN5/42R5ZJQTOR/ga38Bk1n4st56aMvUD4dcFmsB6lTBX
         5J6SpRIx0/0ZyZXr/IQdxHcENEtyjKeFdypwy/MB2hhsWG7JjMAAcRhCk+XAxej3DSi1
         UA/Cjpy/8TJ1bErSNiA6CuW01ah3Qd90UlJdIEcwHzqtWzWOzxfdjZA/A0XIcNgJyt7W
         ICRIoClFYcwMNhAEr1h1d8t6ejw5gvKc8CG4Fw37sKW0mKNOD+XXXmNlncJewocGl8Mt
         WSxW1Pc6ytln/jcO8WJt9C+YjG3hhhPG7cAAU4fuqnRJAO4N/dwCEPnADuRlXv1JObVy
         wPGg==
X-Gm-Message-State: APjAAAU2uAlfK6l5ASO0Gz8kquvI3GNbjMQxben/R/2XW9eEcLoypmEV
        WXaDqEQpmSndm0fOTmdFRkhqHI6CJuY=
X-Google-Smtp-Source: APXvYqzS/ipkpGo3nJd8w25N+g60WqQ1WzHcInhSZRUv5x4IGfs+C6xmKC4mcuaVLrbE7X+s7u5GFA==
X-Received: by 2002:a50:9855:: with SMTP id h21mr9488194edb.264.1559286005679;
        Fri, 31 May 2019 00:00:05 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id gt16sm810459ejb.60.2019.05.31.00.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 00:00:04 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7E5751041F1; Fri, 31 May 2019 10:00:04 +0300 (+03)
Date:   Fri, 31 May 2019 10:00:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "namit@vmware.com" <namit@vmware.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "chad.mynhier@oracle.com" <chad.mynhier@oracle.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>
Subject: Re: [PATCH uprobe, thp 4/4] uprobe: collapse THP pmd after removing
 all uprobes
Message-ID: <20190531070004.2dwa2cjol2q7yq4u@box.shutemov.name>
References: <20190529212049.2413886-1-songliubraving@fb.com>
 <20190529212049.2413886-5-songliubraving@fb.com>
 <20190530122055.xzlbo3wfpqtmo2fw@box>
 <4E8A7A5E-D425-40EC-B40A-7DA21BA1866F@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E8A7A5E-D425-40EC-B40A-7DA21BA1866F@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 05:26:38PM +0000, Song Liu wrote:
> 
> 
> > On May 30, 2019, at 5:20 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Wed, May 29, 2019 at 02:20:49PM -0700, Song Liu wrote:
> >> After all uprobes are removed from the huge page (with PTE pgtable), it
> >> is possible to collapse the pmd and benefit from THP again. This patch
> >> does the collapse.
> > 
> > I don't think it's right way to go. We should deferred it to khugepaged.
> > We need to teach khugepaged to deal with PTE-mapped compound page.
> > And uprobe should only kick khugepaged for a VMA. Maybe synchronously.
> > 
> 
> I guess that would be the same logic, but run in khugepaged? It doesn't
> have to be done synchronously. 

My idea was that since we have all required locking in place we can call
into khugepaged code that does the collapse, without waithing for it to
get to the VMA.

-- 
 Kirill A. Shutemov
