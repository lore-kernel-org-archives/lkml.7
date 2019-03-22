Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348ACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9A1218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUzkCPGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbfCVMEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:04:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37718 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388316AbfCVMEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:04:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id q206so1398187pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4AWblRo5ewuA/4tmoQynrYwrFjG+ERQg40eyX191mqY=;
        b=TUzkCPGo/SWoUh3nwd4QvDz4O/5nV2yLzP0SuahLZ5a6Grdb8EvlCAcIvBCVXUGVpN
         09peSDYhlYVB2yhqbOOlRXxdAt9QqbvOQbplPhEOcpq/q9XUDttcWNKSEkYIVDG7ARiL
         OSwrc1UOsqpzJzmvMOrlke7HydMGak9husvRVn9JvMfigu+2mv7NEsD8HGVEHzpTppjV
         eyuuvHBwv+4NgeEb2w33i27cyRfpy1rUgc0X8bj1v2vs8+UtNjTqJJfFaDNYig0+tVer
         xEOqyKbFQesO4PffjpoZR9oSs3Fu7Wc2ZiDYOkXIJs2ZQWUJCQ17RZpTzEfdyshFWNcq
         /kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4AWblRo5ewuA/4tmoQynrYwrFjG+ERQg40eyX191mqY=;
        b=coVv7uFO8HHNn7tjNDu72Keu5dOTEQ5bY8VewIRP/YAdo79d35XpjURDkYBOfM6Xf/
         Ds2cllH6LVxZokm2Vd5nxpFtURrafHzJS/Sgu/KALj/rlpH3oX1wopq+kpFFtQa9VaMX
         xjmIifD66FBUHbgy6mFnz+0u0HkgATSe+x8qmKB6xT7YBl4YVmel4vootOEjif0jqOnX
         BbXrhnR7QEZQIYFja1HOYbrzceCG6ugdXNYdejaXkR9XSdgn0JM0AEMYpjUfbTFzmwe9
         iZnzyQGSzliYf0SpUGLEr1lwqivSryww3On6oCEnJouBH0pCVZHpnW3VuvZ9IZNdLPxL
         u+Kw==
X-Gm-Message-State: APjAAAUcDwLvX0LuZPa0rbRQDTh/jXyWoUvV+fu/HBQqqiIT8tUCr8/g
        jBsfEc5kEOETG+BUa4zTPPg=
X-Google-Smtp-Source: APXvYqz7kKZrT2PMCc9qfrbj8h0X9Txt6DTvb8QGnvNfeDFRUP4lBWrXckuTCulpRdgGJkWJoMCULQ==
X-Received: by 2002:a63:c10b:: with SMTP id w11mr8624018pgf.39.1553256273504;
        Fri, 22 Mar 2019 05:04:33 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([117.198.99.29])
        by smtp.gmail.com with ESMTPSA id d3sm9981973pfc.125.2019.03.22.05.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 05:04:32 -0700 (PDT)
Date:   Fri, 22 Mar 2019 17:34:27 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, christian@lkamp.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ralink-gdma: Change uint32_t to u32
Message-ID: <20190322120427.GA3031@bharath12345-Inspiron-5559>
References: <20190321192502.GA11144@bharath12345-Inspiron-5559>
 <20190322100140.GL2202@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322100140.GL2202@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:01:40PM +0300, Dan Carpenter wrote:
> On Fri, Mar 22, 2019 at 12:55:02AM +0530, Bharath Vedartham wrote:
> > This is a follow up on my previous patch. Change occurences of the
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I did not send a patch set. I should have worded my changelog better.
Thanks for the feedback. This was just one patch.
> Put this sort of information under the --- cut off below the Sign off.
> 
> > stdint type uint32_t to its shortened type u32. This fixed the checkpatch.pl warning: "Prefer u32 over uint32_t".
> 
> This line is too long.  Limit it to 72 characters.
> 
Yes will do that.
> > 
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
>   ^^^
Got it. Thanks for the feedback.
> 
> regards,
> dan carpenter
> 
