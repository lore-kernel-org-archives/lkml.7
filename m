Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A20ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626EF21835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571335988;
	bh=YsEXv1Ag6Y9p4PdBVelETQwyKMBEOxANKRtzazw/7yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iCqaYZUDL0votnei79An2Gg6GOGjBrNE0qFIIpL5v+W+qpwOfbABPy7wGsu+/HRM7
	 kmDrPjWgQcnmjpOMmUr52ou3wn98J493bGYtJBerZOcRwoqq26y+zEvnOpsRuP6HFM
	 ycEZagxBQPEtLR5k3O1KGeS2ezbYoSITj2EQdIJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438489AbfJQSNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:13:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36667 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395229AbfJQSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:13:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id o12so4982530qtf.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 11:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQJU8ci8oY6Kab1RQlvPMrQvM9tpnFR5fWTaEdpdtno=;
        b=h0VkyBEm9O0btEGP/lHytb2SrfiXtOjU/gKvIMhy9TZyPl1NioOFDJk+aItTS7smgB
         h4o/ZHB/nTX6P2b4zMG/fjU7d8fic0yS5CqBkdxcFFoY/NAebzLnosBG3VJUkeNdb5Fo
         628y03lQnaLhGACa5ggE+8JDHBDe2Z0nnHfKKi7cTEFBcNHDLF2DARe/0CGg7l79qQJG
         frFJGNUP76yIANeZr3TiDq/xXB65tGvFIFy8+0QYt2pGZOLSiMDENegiEl9rwYFPJlEd
         zMIvMF4rjCtbyv2QB2J4fx8ygpUwKMaulhGb1DXG7o2PWQHrQvYQalx9+6avl9pDKr5k
         cSNQ==
X-Gm-Message-State: APjAAAVmRJuNnKAcro/OFuuTudIBLoiwxFizHIv3akWMc4tmktIb2EOH
        8dytbn7hpB7DePZbxNGOm/OlxL4s
X-Google-Smtp-Source: APXvYqxQSw+u7RppInZfrdoaAbDA1VVXZnYpu9J7+x/uisCAzaZnnuQ3XNoW9AvKYdAsXGRJFuX/vg==
X-Received: by 2002:ad4:4345:: with SMTP id q5mr5354801qvs.80.1571335985682;
        Thu, 17 Oct 2019 11:13:05 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::2:ef38])
        by smtp.gmail.com with ESMTPSA id p7sm1678886qkc.21.2019.10.17.11.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 11:13:03 -0700 (PDT)
Date:   Thu, 17 Oct 2019 14:13:01 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: add __percpu to SHIFT_PERCPU_PTR
Message-ID: <20191017181301.GA32546@dennisz-mbp.dhcp.thefacebook.com>
References: <20191015102615.11430-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015102615.11430-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:26:15AM +0100, Ben Dooks wrote:
> The SHIFT_PERCPU_PTR() returns a pointer used by a number
> of functions that expect the pointer to be __percpu annotated
> (sparse address space 3). Adding __percpu to this makes the
> following sparse warnings go away.
> 
> Note, this then creates the problem the __percup is marked
> as noderef, which may need removing for some of the internal
> functions, or to remove other warnings.
> 
> mm/vmstat.c:385:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:385:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:385:13:    got signed char *
> mm/vmstat.c:385:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:385:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:385:13:    got signed char *
> mm/vmstat.c:385:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:385:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:385:13:    got signed char *
> mm/vmstat.c:385:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:385:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:385:13:    got signed char *
> mm/vmstat.c:401:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:401:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:401:13:    got signed char *
> mm/vmstat.c:401:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:401:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:401:13:    got signed char *
> mm/vmstat.c:401:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:401:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:401:13:    got signed char *
> mm/vmstat.c:401:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:401:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:401:13:    got signed char *
> mm/vmstat.c:429:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:429:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:429:13:    got signed char *
> mm/vmstat.c:429:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:429:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:429:13:    got signed char *
> mm/vmstat.c:429:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:429:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:429:13:    got signed char *
> mm/vmstat.c:429:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:429:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:429:13:    got signed char *
> mm/vmstat.c:445:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:445:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:445:13:    got signed char *
> mm/vmstat.c:445:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:445:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:445:13:    got signed char *
> mm/vmstat.c:445:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:445:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:445:13:    got signed char *
> mm/vmstat.c:445:13: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:445:13:    expected signed char [noderef] [usertype] <asn:3> *__p
> mm/vmstat.c:445:13:    got signed char *
> mm/vmstat.c:763:29: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:763:29:    expected signed char [noderef] <asn:3> *__p
> mm/vmstat.c:763:29:    got signed char *
> mm/vmstat.c:763:29: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:763:29:    expected signed char [noderef] <asn:3> *__p
> mm/vmstat.c:763:29:    got signed char *
> mm/vmstat.c:763:29: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:763:29:    expected signed char [noderef] <asn:3> *__p
> mm/vmstat.c:763:29:    got signed char *
> mm/vmstat.c:763:29: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:763:29:    expected signed char [noderef] <asn:3> *__p
> mm/vmstat.c:763:29:    got signed char *
> mm/vmstat.c:825:29: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:825:29:    expected signed char [noderef] <asn:3> *__p
> mm/vmstat.c:825:29:    got signed char *
> mm/vmstat.c:825:29: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:825:29:    expected signed char [noderef] <asn:3> *__p
> mm/vmstat.c:825:29:    got signed char *
> mm/vmstat.c:825:29: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:825:29:    expected signed char [noderef] <asn:3> *__p
> mm/vmstat.c:825:29:    got signed char *
> mm/vmstat.c:825:29: warning: incorrect type in initializer (different address spaces)
> mm/vmstat.c:825:29:    expected signed char [noderef] <asn:3> *__p
> mm/vmstat.c:825:29:    got signed char *
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/percpu-defs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> index a6fabd865211..a49b6c702598 100644
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -229,7 +229,7 @@ do {									\
>   * pointer value.  The weird cast keeps both GCC and sparse happy.
>   */
>  #define SHIFT_PERCPU_PTR(__p, __offset)					\
> -	RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
> +	RELOC_HIDE((typeof(*(__p)) __kernel __percpu __force *)(__p), (__offset))
>  
>  #define per_cpu_ptr(ptr, cpu)						\
>  ({									\
> -- 
> 2.23.0
> 

Hello,

I've applied it for-5.5.

Thanks,
Dennis
