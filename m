Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2A4C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0222721920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xjuz7ftx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfJBO1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:27:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41434 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfJBO1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:27:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id p10so15159450qkg.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j42XyKqFcfiw1cr29A4t69KcsaFULzlrkf42oLnY4+U=;
        b=Xjuz7ftxaEpV/qP+oM1bSUx7IMqT48FwXeOpaeJAak2QkBGKSVdNMwSG00tuhJKGy5
         gmQEiW6bBSnS+cuAuSw0aV6KU+c9RElg0ZxKwCEqavwKJf/qLw6hJKXaDA8UrwuDe4p0
         aQoeFWuHXDVqXXFwI7Lqwxecq1/BfYjsfTxkGzqz2CaS5AH2bt6JF36izHYeny09xTY7
         wG2aUGDtL0selcwkl7TnDLMYiGK4da2cpmpcmRj1jkJgfE5BLCtpqXrj8WmeJUZ5YRGO
         xRb8swZ7hSYBdXwbEA/s/5akRjq0v0YYjPWEpgm7f4LHCgStMD8PwAAcYw5h/uwPyhr7
         b/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j42XyKqFcfiw1cr29A4t69KcsaFULzlrkf42oLnY4+U=;
        b=OjT4eccEM6HKlQVObih/GdweuRUpPugpzVfOhTIZ/rYZDKkDSd9PJHq1xQXuAK9686
         q3b4YToY+/gxXOc66+DL6aBdcf3QkwNDl8/6AVbLH6yCeaWqDwhxwAXQlOqT0OkcpbJB
         rMvQE/7s2Dptw2jczKl43hvih1CgA1RTBktqNTT7rn+wBE0dOl3hbiyTep4OdpJisqY+
         IViVmuH/7pVUZ8Y0TghYjrGtbcZtcRzpHvV2/4xkmupbJJxvNQt4osXCW1WTdQk+df0t
         0yqnpha7CAyO5ry5GE/UFo1Lc9MIAYucCrsI0UAQlIRw+KL+S2rlaeVqB6eyRJzRPl9T
         mzmA==
X-Gm-Message-State: APjAAAVX1W8ES8/oy/FVaxNMJ1WZTCzqilwChfLnEftEfSqURyYPWGVD
        J//G0ygUNToo3pRYYG5I2Vji6w==
X-Google-Smtp-Source: APXvYqy5l1q7x1+hEbogRi+HhsXpijaCnQ4w4w5ms+iIWkrFLypPdnjOoPV+KDeN3liFVu2MNATFWg==
X-Received: by 2002:a37:a24d:: with SMTP id l74mr3778096qke.200.1570026452312;
        Wed, 02 Oct 2019 07:27:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c14sm12117764qta.80.2019.10.02.07.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 07:27:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFfbH-0006sa-4a; Wed, 02 Oct 2019 11:27:31 -0300
Date:   Wed, 2 Oct 2019 11:27:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        christophe.leroy@c-s.fr, thellstrom@vmware.com,
        galpress@amazon.com, palmer@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH] scatterlist: Comment on pages for sg_set_page()
Message-ID: <20191002142731.GC17152@ziepe.ca>
References: <1569954770-11477-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569954770-11477-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 11:32:50AM -0700, Alan Mikhak wrote:
> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Update the description of sg_set_page() to communicate current
> requirements for the page pointer parameter.
> 
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
>  include/linux/scatterlist.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 6eec50fb36c8..6dda865893aa 100644
> +++ b/include/linux/scatterlist.h
> @@ -112,6 +112,12 @@ static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
>   *   of the page pointer. See sg_page() for looking up the page belonging
>   *   to an sg entry.
>   *
> + *   Scatterlist currently expects the page parameter to be a pointer to
> + *   a page that is backed by a page struct.
> + *
> + *   Page pointers derived from addresses obtained from ioremap() are
> + *   currently not supported since they require use of iomem safe memcpy.
> + *
>   **/
>  static inline void sg_set_page(struct scatterlist *sg, struct page *page,
>  			       unsigned int len, unsigned int offset)

It seems a bit weird to have a comment explaining that 'struct page
*page' must actually be a valid pointer. Of course it must.

Computing a 'struct page *' to something that doesn't actually have a
struct page is simply a bug in whoever did that.

Code should never be interchanging ioremap results with the struct
page* world.

Jason
