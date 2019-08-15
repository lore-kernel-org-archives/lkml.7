Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2548DC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4766206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="JPhe+CSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbfHOTBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:01:24 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25526 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfHOTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565895679; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=kuwNbvZEznqYeyxM5UUcX3s0agFxk6ZCUnPKRwFHqnJ5SG49PdEjqOwHF94laIu/DPMnIyPaRAat1ukL4pkRq//s2ciTVUEWDz7Bemw6ym3Cn90EmWl8XBzkYp/FydGKZF39Lw8SJwx+7wf1Co4v8k5LNFTYGbMXFzNYb2Amyvs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1565895679; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results; 
        bh=BjdD8Z+8TvyMFon+OHZtpBgAR0etF3ypGYj1vttBWEA=; 
        b=KJPgrHYqdellYi9oE21o/6Ww6igAWdy3VFji4iLE6/Dk/biIG1mks/WS6mRkkYWHscTu4ubq1YM38DO/v2QiL+RycfF4vzTPJsR9HqxDrkj1NxuTv4vwkxEd2qNlwv9gvAvCubewzKTgJHXbryoMunwFm+HKsunWbCinUk3ZNj8=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=to:reply-to:cc:from:subject:message-id:date:user-agent:mime-version:content-type; 
  b=fCWIpZJ4uB+W9wCFv/2CQXfTLFFEmrHTFlTcNhSTPKKM0zlWA2r53d5uVWr2Cf6nA1JrUWhl3N84
    0zAjpntLbUB5f4xPto0lFJquEi+yxZVsI6qrWoNYlwETQSTmpTcp  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1565895679;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=To:Reply-To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=455; bh=BjdD8Z+8TvyMFon+OHZtpBgAR0etF3ypGYj1vttBWEA=;
        b=JPhe+CSboOJHpyuXzsCmHLkvNLMm2CC38UoHHb0wCYFWLg8Tl0UwdNvtovVpKCcU
        pZyGFLF9oh/dLxTkRW/u1dLzZ3xmfzb/GtdkqU3WI2CTCdFuNBiHMXQNQgF5LlXqu/X
        e24+UYd4cmP7dJ42PEj8/l05ScLSZne/r4PH9vDY=
Received: from [192.168.88.139] (61.157.36.160 [61.157.36.160]) by mx.zohomail.com
        with SMTPS id 1565895678907660.9071439114288; Thu, 15 Aug 2019 12:01:18 -0700 (PDT)
To:     prasannatsmkumar@gmail.com
Reply-To: 20170927151527.25570-1-prasannatsmkumar@gmail.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Subject: Re: Add Ingenic X1000 SoC Support
Message-ID: <5D55ABFC.9050209@zoho.com>
Date:   Fri, 16 Aug 2019 03:01:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi PrasannaKumar

I am also trying to add a series of Ingenic's processors.
I tested your code with the X1000 development board and
it will get stuck in "Run /linuxrc as init process."

As you speculate, last year the sold more than 500Ks of
X1000/X1000E, and customers have big companies like
Honeywell. So it makes sense to provide support in the
mainline.

If you need, I can assist you in testing in your
follow-up work.

Best regards!

