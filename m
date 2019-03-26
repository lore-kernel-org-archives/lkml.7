Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6425C20830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVrUFhly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfCZK16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:27:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55096 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCZK15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:27:57 -0400
Received: by mail-it1-f195.google.com with SMTP id w18so18658036itj.4;
        Tue, 26 Mar 2019 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tlAk1qNw3eNBVB2PmRA+DTGTHvUydulAWbcIGX59EZ4=;
        b=aVrUFhlyI99XTFkw2vLuUB98sj5T4+hOrAFCMv4C3a0ZZK+6XCjzgA1IHP7Z/4DwHZ
         Xdap1DfOPvhfeVJWrwG+nGB0p4LNYdjW3PumIUjibIsdYc/YcCJW63oJOl3w7Le8EdEE
         CYWWvpDsXEZaioB4wAKAhKkOCs+wQ6KunvteIzQcgCiLb8eYGo/oM+ocNYZJhD/mbpma
         H8oXa61dppX1ARN4QO/o82lbugUrLuG8ZEw4ElEFYzMvvZYPY+TOcSrVklk+6vWxMulO
         1QdZmTNGXsaL0gX+QSQylrZiApBMcmIHCrFUR9N/05pnu9vHgZ1tNpCEFhhQ8TPt8SwR
         vREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tlAk1qNw3eNBVB2PmRA+DTGTHvUydulAWbcIGX59EZ4=;
        b=ceOtnS9Ffm5KwlrmkwaFfIeGc9sX+/11Xvqyivwbxw+Tp8KNvPk6wREUwMIzQ/tqOf
         wjwtw02VEZomsKGeHlRvIkGWQgvglkST8XnbLpFCr2U7FHbFGV5OWXIYu0VdXn/x+JC1
         PJAkwEBIeTzg7gbphWVRKDgOSfXtB1mZV0cMCzbAuLCKgE8S1BVOlvhi9OXoQiUyNO8S
         HIT91ad4ftm0tW/8dl81+LzJXv9oOhmlL0xGU5agi5ZygXiF5I1/dpUGXL5sv7e1R3d1
         WSemDYQmQaIvMoZ4hh1P4pht6BIgjN/a+pNODGwBVnDWBIywwoPMOUlW+k6LmPCuncFz
         V04Q==
X-Gm-Message-State: APjAAAWeKiU+Qh+XLmM0EZkWrA5FaWseoPwbPkMPEFpP311/7PE7c6/W
        EXyyuyh8HP5Nwg2njoHIYMs=
X-Google-Smtp-Source: APXvYqz/z5o6AGGjvZqJtOqCmcJg/Fmx/lsbE8dWLic1WRDu+bKdXUFc0Ol+LWRIvpjc+mnYEBRmtQ==
X-Received: by 2002:a02:ad03:: with SMTP id s3mr15848938jan.3.1553596076455;
        Tue, 26 Mar 2019 03:27:56 -0700 (PDT)
Received: from icarus ([2001:268:c0a3:6e7a:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id b74sm346086itd.12.2019.03.26.03.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 03:27:55 -0700 (PDT)
Date:   Tue, 26 Mar 2019 19:28:43 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190326102843.GA10264@icarus>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
 <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
 <20190326031422.GB3356@icarus>
 <20190326094345.v7l7xjvfs2scbvbv@wunner.de>
 <20190326100743.GA10005@icarus>
 <20190326101933.GW9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190326101933.GW9224@smile.fi.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 12:19:33PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2019 at 07:08:18PM +0900, William Breathitt Gray wrote:
> > On Tue, Mar 26, 2019 at 10:43:45AM +0100, Lukas Wunner wrote:
> > > On Tue, Mar 26, 2019 at 12:14:22PM +0900, William Breathitt Gray wrote:
> 
> > > Why is it so complicated, does it allow passing in a start value
> > > that's not a multiple of 8?  Do you really need that?  I imagine
> > > a simplification is possible if that assumption can be made (and
> > > is spelled out in the kerneldoc).
> > 
> > That's a good point. Originally, I had envisioned the possibility of
> > calling bitmap_get_value8/bitmap_set_value8 at odd start offsets; this
> > would open up the possibility of a clump landing as a split between 2
> > words, thus requiring this complicated case handling code. However, I'm
> > not sure how often users would need this case; none of the drivers right
> > now require clumps at odd offsets.
> > 
> > Andy, would you have any objection to restricting the start offset
> > values for bitmap_get_value8/bitmap_set_value8 to multiples of 8? That
> > would prevent the split word case, and thus allow the implementation for
> > those functions to be a lot simpler.
> 
> No, I have no objection.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

In this case, bitmap_get_value8 could be simplified to something like
this:

        index = BIT_WORD(start);
        offset = start % BITS_PER_LONG;
        return (bitmap[index] >> offset) & 0xFF;

Or if you prefer a single line:

        (bitmap[BIT_WORD(start)] >> (start % BITS_PER_LONG)) & 0xFF;

Would it be better to define bitmap_get_value8 as a macro then?

William Breathitt Gray
