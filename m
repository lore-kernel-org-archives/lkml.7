Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549D9C28CC4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4882581B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="0PlnzpEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfE3LRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:17:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35937 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfE3LRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:17:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so8629854edx.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 04:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j5JEqVXlVPuBEonAgRReuOAgYKsmvONxrJze6kAXdOo=;
        b=0PlnzpEVh/okUS9ehO/eYwgZScgoO1vT9pyY6qDTnILbQOvfTJYA167Nn4JWBH3Ftc
         6Y+hprFUgFL3UPabg+xZjQM+Q9gEZYjg/YtitmOwWeyaEDNggCHOoDsgp+B0yv9An+gl
         3gzP1Y4jLCYGy80AGCaF93qRLcAvXwWRo8jl5xV5a9x4JXvYRYVLjOnGn48uyAcVfRfC
         xuoBjFy3W5MS9zFjl7FgTaYuqaj13MjPxyA//Ggu0VHUX1FpiVa90ajT2iRWLDy2iThk
         2JW3PzhWGP80GjN3M/NuHhj1Jk8p9YFr0XreKy8zOTjODr4dGdccPu989cPJnQlD8WnL
         sjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j5JEqVXlVPuBEonAgRReuOAgYKsmvONxrJze6kAXdOo=;
        b=HJ29A2YbUEJN6QbM6Ggnl6Dwt7zhnQlymet/k58bU+GvXfz9rTGGtgybJ5niqpv/At
         0INiOxoFS6CMFDSwnjCBgTvaZBk9q/nBtTrsFQY8B8DAJxDmdRUZ0v6NQFkfpcpaftTR
         nDdVhPFcNi+EuMqeWc/nGHpV4b/imLiWIXeYhLH+Ys8+7RAGEM6vVrcHwGMI6iP5/90z
         GRyBmO1QgG+9ltSrDpyeKOLu0EuH10cECbZtPDDzBKW71UleDhqxUcCWNO1Kei2F3fi6
         i/Hc04XtRCkUjSA5eSNaHmPrkvKGk5YnmFMJ0S+j/i0YuDL9vHz9JqLI2z3wjlOvytpr
         k4nw==
X-Gm-Message-State: APjAAAV9dc23QP1EQIXOexKBlbzsVqEwdTTtabWiMrh8dnuMDmMYaC5d
        C92rrLPCQGkkah7xGK4RhhgllA==
X-Google-Smtp-Source: APXvYqybXw5+XBpfHSRQmjqUA1kS1y3KdUHm4S7KXKtP9Yh4Mq7RHInPJ+fJ7G/FJg0fkfWxmCkmRA==
X-Received: by 2002:a50:b062:: with SMTP id i89mr3887679edd.85.1559215061571;
        Thu, 30 May 2019 04:17:41 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m16sm376289ejj.57.2019.05.30.04.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 04:17:40 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B28291041ED; Thu, 30 May 2019 14:17:39 +0300 (+03)
Date:   Thu, 30 May 2019 14:17:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, namit@vmware.com,
        peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, chad.mynhier@oracle.com,
        mike.kravetz@oracle.com
Subject: Re: [PATCH uprobe, thp 2/4] uprobe: use original page when all
 uprobes are removed
Message-ID: <20190530111739.r6b2hpzjadep4xr5@box>
References: <20190529212049.2413886-1-songliubraving@fb.com>
 <20190529212049.2413886-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529212049.2413886-3-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 02:20:47PM -0700, Song Liu wrote:
> @@ -501,6 +512,20 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  	copy_highpage(new_page, old_page);
>  	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
>  
> +	index = vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
> +	orig_page = find_get_page(vma->vm_file->f_inode->i_mapping, index);
> +	if (orig_page) {
> +		if (memcmp(page_address(orig_page),
> +			   page_address(new_page), PAGE_SIZE) == 0) {

Does it work for highmem?


-- 
 Kirill A. Shutemov
