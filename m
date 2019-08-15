Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C203C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0325D20656
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="sL6BRssM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbfHOTUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:20:06 -0400
Received: from sender-pp-o92.zoho.com ([135.84.80.237]:25414 "EHLO
        sender-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbfHOTUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:20:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565896805; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=ToUYJHjmk7lpJ+dO3YpfseDKqZw9BYdMByPDEzcpmoLBctkyRxQ5IwKMnOQByWr4ZYkxD5GxEatcq7HePJaHGVXe0fsrjmC1tQ0U4SaumeWTcV65lMJFtLSHD7zd0NCSxSVLrcxdJ0yYHWyxiS3xwAdU9YNZQQMHrMo9l/0d99k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1565896805; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results; 
        bh=BjdD8Z+8TvyMFon+OHZtpBgAR0etF3ypGYj1vttBWEA=; 
        b=gSSfk2vqe+YrGcGO/DhQowvajL1uNS7io7NAzTLwcLE1/yITKiVRa++owLvyMtUtImhSecKeqpaWLZldh6Tbg2doeQffmi/xqnEBL5auKvymQe1lF6mwzbtvybF6B4/dRHkX0ChUweQYygR2BHva5TuSzYygU59aYcRjD7U+GPw=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=to:reply-to:from:subject:message-id:date:user-agent:mime-version:content-type; 
  b=OzUX9UIWFxVg+nCC27Uw9B8S23t5FncHvZ/0o7TOuK/mSt6F1IxMXfPI75t/IHWAodH8MAgzn/xn
    Fm7BWVAh8sufrA6RCm0Z/0X3WpURo8bBUC8nNE6M1nvJkWOUykwL  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1565896804;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=To:Reply-To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=455; bh=BjdD8Z+8TvyMFon+OHZtpBgAR0etF3ypGYj1vttBWEA=;
        b=sL6BRssMEbPt0yL+IQF1MgLddXOFf/xR3szhcLYHLd8kip/mmuRfZcXlukXNuw0V
        GRsyVOPewgewZ6K/Acsj+xPql9WSPDEMdxTIpfbAr3ecwR1N+GgxEsDeVyaSd3gEkkv
        jTZMny4Mg7D54XDvfEtObbYdCEKyEXly7P7LhFcI=
Received: from [192.168.88.139] (61.157.36.160 [61.157.36.160]) by mx.zohomail.com
        with SMTPS id 1565896803277457.8883941588708; Thu, 15 Aug 2019 12:20:03 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: 20170927151527.25570-4-prasannatsmkumar@gmail.com
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Subject: Re: Add Ingenic X1000 SoC Support
Message-ID: <5D55B061.5000608@zoho.com>
Date:   Fri, 16 Aug 2019 03:20:01 +0800
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

