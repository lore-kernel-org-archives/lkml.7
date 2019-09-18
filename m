Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C661EC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9515620578
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="hDaUEL0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbfIRVLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 17:11:38 -0400
Received: from sonic309-21.consmr.mail.gq1.yahoo.com ([98.137.65.147]:38440
        "EHLO sonic309-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387891AbfIRVLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 17:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1568841096; bh=xSHG3EIZ0k+rLhhcL+KETbZod5iOR13q2gPptS/oso0=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=hDaUEL0ZTAW4bmKZz+BA7kG2cWwKKLQGdsQ0zTYwgT2odk5LiTwzgqxopfxZS402XI/7UlB2cLY6E2CbbQIQSyiaNKNDXhJ9U67FWDZLehYs3xweydRcQIUJSoB1OoakvybTDSnQVyduEiqZD4kx1ghORt5hbOJ6Pp17nzCsuOFHzc+hSVnWBSMQadaCotCZB3Fp4YJP/wGD3CjPquJulQ38kKfNwA/x0yXEE+tflfX60plD/IB2GMiB9mdPZzmxHIe5vKjFUJrTWRmwFFQzuoeXytbLhw0Er5GbnHIz3VXTxt1Fk75mZqCqi2eyWYJb85vIf82RtRSYk7Rbs4mXQA==
X-YMail-OSG: oJ_59lQVM1kMKsLpLO6akkyoogSCgRXlUQQ.TYWCfVIWWvo4e84ms12E.ocC6F8
 uARyTVOrPeXXFhaZuQishS7DJyfIB7nFNkrBNi4nLjZpgALjM8skxg1NSU9IvUeYlPcvVLFE1KMl
 E.1FIy6EbzPwzAotxmf.6FZQdzak35GkEP2GjktWnkdvmgp7LVy4qUZMRxhwTBZKzQAtWd.0yh77
 .pmzGKR1VRxnQ9Qc33Qf2n8nXcNVpc1rbzjUfHk7xGOp9NqciPIisWKHfOQvu3lE_eZkF4CJ4qp6
 M6OZN7_QDqDRs2YajUh3xkdnT.u76gOVkB5cPsFVOFo4LPbNj5dWcTCJVFY.QTxrD5t.LIpfJdjb
 vx0XYfVZCBdN3xfpX60jvSO4ssKVhi4XVhjal3ecxahEUOWwq.VzXcySZDRrMFN0Jg.l1EdVH9nM
 Hoc.rqlN3sr6X89DqmdJDwr.npU9bTTPAr3.BlN8ogWOoChh6N9uwyJ_ZbabPZTrD8VUbsgZQjha
 TPXQdUQ9e8fd6MDeEwwJHSlQHnlTbqONnRAF5ZsQCSnC68wbAkY7LCv_tXyKxy9qvrN9kHcTgUHn
 v9BRwnLN3Pk8v8l9O7QXrSBsRoqJMrB.jO.zKmQLsTUhLd6cyvLQyM7B_QWFTdyT.NICIrnuKINs
 0IWc730rNg071x2zj5nBToqr80gvB978SjKqClHfMcE39RH11cVuiIJgyKTYaEfV6TslxEiLpZ8_
 m2O2U2s.W3aequUqxyfFv8nIQLmwXaWTISLxnJKLQwTw77ZPeHwrbOZxG6kpTNuG9sdcnOXXQqoT
 9uQHifxVKb3sQk4uL64IcJP94.2ye2JJiDccUD3cK_iMQn2hk1Ix13TMeUblbn2agKk.fjnsGYCA
 _z72ugVvrcxKZS94HWwhKDgI2h77ApmZXf7z4dzDNrAo2J3G8JLGnQIt4VX8Kk_N6XntFUo3vztw
 SKU5bdEIFqn3pCK2z6TGWaVE0maiP7yRwLWBmkLLkauiJpIZc1l7jmbCekhDAsKo5wglkliotX.i
 ZU4Zh98asDrvtMGO.RDhz2TPRRcrQQwM7_FOP6RUclKlR0amTn9FH6SJI4YSIun7aONqh5y.dT9O
 lXiJZYHm2xcWwpNTZf_ZfjZDyhOxPAT8BgvyOjgoSGjHIZsB1V0I7pGEYYZkYuzXq8oDUqCTAKs0
 GtboXHdYu_uIYVGItbBBtA8.UyXIAqpyLUkBCWPL8CKDaRj1CzuHntq4j6kcFozgrt6aQ.UkII94
 Mc4ByY2GDDl0HLCAE2GWOP6Vlk3sPOvanktjLxCO4sjkBCE26KlshNG5Vhu4N.cZaYKBgN.3J8GJ
 W3uJ1bVR2_gMqblv.hseDfFvciVepY11ShbJMh3_mnF39
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Wed, 18 Sep 2019 21:11:36 +0000
Received: by smtp425.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0a9f3fa91ef1e412436c99f74f3086c4;
          Wed, 18 Sep 2019 21:11:34 +0000 (UTC)
Date:   Thu, 19 Sep 2019 05:11:28 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.4-rc1
Message-ID: <20190918211123.GA22600@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190918114754.GA1899504@kroah.com>
 <20190918182412.GA9924@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918182412.GA9924@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailer: WebService/1.1.14303 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, Sep 18, 2019 at 11:24:12AM -0700, Christoph Hellwig wrote:
> Just as a note of record:  I don't think either file system move
> is a good idea.  erofs still needs a lot of work, especially in
> interacting with the mm code like abusing page->mapping.

I know what you mean, that is a known stuff in the TODO list,
Z_EROFS_MAPPING_STAGING page->mapping just be used as a temporary
page mark since page->private is already pointed to another
structure, It's now be marked as an non-movable and anon pseudo
mapping and most mm code just skip this case.

I think a better way is to use a real address_space structure for
page->mapping to point. It's easy to update but I need some time
to verify. If I am wrong, please point it out...

Thanks,
Gao Xiang

