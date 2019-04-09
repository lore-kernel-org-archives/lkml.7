Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E616C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3401D2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seDBlpFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDIVjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:39:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45365 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDIVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:39:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so28467pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3E2FOy8x1C8PeWo0iww95N4zjbBychmOM5H9qAVH6SE=;
        b=seDBlpFUhmSpqUnrew5lja+uJtWYiuL3yh67fw4x/UZR1Q/py3jH5uz/M/TVoibiKf
         MCE9zjzcEJe3IJnwYcJphFh8eLBuN7hCO96ZBSptWSW29NalxHzjNg0nf5lxK/nTuJL7
         GqEwGWvuxAa2uTAJU/bgOkPAsrmZrewJID0XKzQP+4EQJF4znaUTz1UsXlllFe2l9hlq
         1n4CxEC0oXdsCoL3aedeKdiKK9NbKywhjxwo/Q4+xOi+0cOEEkgowoEkbXdaAIuCjEA9
         9BiZhab73DlQzmdkhGOWPsDz8ewxpjFDHD8tP1Rq/R48bqHt/e3EotutNFStlhYAom6P
         b8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3E2FOy8x1C8PeWo0iww95N4zjbBychmOM5H9qAVH6SE=;
        b=MgEWOT5L1xkKRie+VAfEyscsAR1g/iaIM0vObDV7Lkl4LToNE41cayloEBsFOhqn0t
         eo6QyCS5K/spRR0KADstxMfWWyeRrif7zn5R/f+stLto2PlBiv35tP0lVs7EPuaiKQlh
         vECrr+CaqQK+FMA5VL4gUZONW5w7VwvcUi4It5vA6e8iyojrR/3GK76S3ysb03EsT6QS
         dInTKSaANqFPjogWOwWNCX++ryIiMHpko5nu+ypVDxTPn9ikqYuYFx22cqJkceWeUZqf
         bWPQmdmdAhdItco0jbNs73gnHHHJoxgrmEiaXlr7r0Q1P4JBe2xMIfF+LnPRIh/hEGSQ
         WuzQ==
X-Gm-Message-State: APjAAAXyUokLb6aIOHEc6uTk5QwTXVYPc1kJmXBUJPuWNoR1KYL4YjO7
        G/1INEWhpn0tloti3vFh8me+Embi
X-Google-Smtp-Source: APXvYqyGzIbq4s3ZghBqR89XcNQwBgPylKDFlVsyJDfveoSYC3IQ39rifc72plt0w/+d/r0PpEtcTA==
X-Received: by 2002:a62:ab12:: with SMTP id p18mr38818228pff.216.1554845992288;
        Tue, 09 Apr 2019 14:39:52 -0700 (PDT)
Received: from localhost ([2601:648:8303:5c60:c8e:2174:1596:cf63])
        by smtp.gmail.com with ESMTPSA id z8sm41719173pgz.3.2019.04.09.14.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 14:39:51 -0700 (PDT)
Date:   Tue, 9 Apr 2019 14:39:50 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        "David S. Miller" <davem@davemloft.net>, Tejun Heo <tj@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask: fix double string traverse in cpumask_parse
Message-ID: <20190409213950.GA19223@yury-thinkpad>
References: <20190409204208.12190-1-ynorov@marvell.com>
 <b3ce41ca-6a20-a53d-7db2-451e3e700040@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ce41ca-6a20-a53d-7db2-451e3e700040@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:31:50PM +0200, Rasmus Villemoes wrote:
> On 09/04/2019 22.42, Yury Norov wrote:
> > From: Yury Norov <ynorov@marvell.com>
> > 
> > cpumask_parse() finds first occurrence of either \n or \0 by calling
> > strchr() and strlen(). We can do it better with a single call of
> > strchrnul().
> > 
> > Signed-off-by: Yury Norov <ynorov@marvell.com>
> > ---
> >  include/linux/cpumask.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index 147bdec42215..2b87f35c586c 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -633,8 +633,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
> >   */
> >  static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
> >  {
> > -	char *nl = strchr(buf, '\n');
> > -	unsigned int len = nl ? (unsigned int)(nl - buf) : strlen(buf);
> > +	unsigned int len = (unsigned int)(strchrnul(buf, '\n') - buf);
> 
> ack, but please drop the cast. "len = strchrnul(buf, '\n') - buf;"

Indeed. See below.

Thanks,
Yury

Subject: [PATCH] cpumask: fix double string traverse in cpumask_parse

From: Yury Norov <ynorov@marvell.com>

cpumask_parse() finds first occurrence of either \n or \0 by calling
strchr() and strlen(). We can do it better with a single call of
strchrnul().

Signed-off-by: Yury Norov <ynorov@marvell.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/cpumask.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 147bdec42215..2b87f35c586c 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -633,8 +633,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
  */
 static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
 {
-	char *nl = strchr(buf, '\n');
-	unsigned int len = nl ? (unsigned int)(nl - buf) : strlen(buf);
+	unsigned int len = strchrnul(buf, '\n') - buf;
 
 	return bitmap_parse(buf, len, cpumask_bits(dstp), nr_cpumask_bits);
 }
-- 
2.17.1

