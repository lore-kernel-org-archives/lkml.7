Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B050FC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7572C214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyMTGL9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbfDRGad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:30:33 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:35122 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfDRGad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:30:33 -0400
Received: by mail-lf1-f42.google.com with SMTP id j20so725291lfh.2;
        Wed, 17 Apr 2019 23:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/8tISv3+dwO4wXuT3aBhX4D2Yc2gI6zorv3zXPymse4=;
        b=tyMTGL9+P1JncNTXFkC+lERqol2gKONuJwOC9gah9PaJPB579Q/OX8i1B2x2RAYeN8
         U8WSAe7AESJbX3dyueJGQ9R0G0qVEr73DL1mildr6QoN++9pEasemtL0J08wUkTBCRxw
         mRNn7cEfCCzd3dT2wcj2p2XZ4RZoSblUIwr6AMuujW1eXVL5GCbsJj33AzpzGKf5OYqI
         MOS2UXcDfNAzdHdZz5jt6kj6pjHlWGDg3jUHF8/AOf8Or4XuP+oWAzQuamlHADgcLyH8
         YagrF+Yg+UTeh5zvgQ6BoLi571/H6oQZXWuEbhbbBb/ets3Q6EM/bkfDmf7CxsS2/4Xn
         MUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/8tISv3+dwO4wXuT3aBhX4D2Yc2gI6zorv3zXPymse4=;
        b=dO8pDHOgRcc3vgjatLuKGdzrtzIij336/wc4H3Euf3gwpg/q8MrwmPMYHt1FEgxllz
         +OM4FE4/NO25rZQVkbN2UU/bKGUBHjIuKWYMrj0wuZ2BwKs6+UkIy5LpcQ0/HgBM/rbe
         gt2dAPX9EJxHIAFNFuEdwWqfQg7Z/oKXdfwUerYwjsuvSZrWUDsZ1U9pIvgi/+2G/ZEQ
         Reb127SwBZcvKOB5NtBLz1eUreDlECQRWiYZo+KE2JMR4i1Al6qxqoFSuDGscsBydIVH
         WiHjdpl9dF0bJSJE1KWJStKyp/j4HpMoKw2KfnY6wLnhKXDGyfCJpUU+3cMiKeRKvOT0
         pcPA==
X-Gm-Message-State: APjAAAXNk+L52VtK6Wi91AT3t1gecO4G+d6Be2yWDjVsKpOwOeZ3FEWv
        AQ8zBZOS19wH95nHWn5cXpA=
X-Google-Smtp-Source: APXvYqxBDQHhyd3NEcJI9VzhI+Zm+sCpEWBEM0dSD3lJN5z7hkLhDu2TTKEEbSSrbyxR+SfD9LMQaw==
X-Received: by 2002:ac2:4551:: with SMTP id j17mr21174278lfm.141.1555569030929;
        Wed, 17 Apr 2019 23:30:30 -0700 (PDT)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id i66sm209262lji.43.2019.04.17.23.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 23:30:29 -0700 (PDT)
Subject: Re: Issues with i.MX SPI DMA transfers
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>, Han Xu <han.xu@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
 <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
 <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <VI1PR04MB454302BAF353124ED13747DC892D0@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <VI1PR04MB4543A5CA46FBB3ACC9F3B3E289260@VI1PR04MB4543.eurprd04.prod.outlook.com>
From:   Igor Plyatov <plyatov@gmail.com>
Message-ID: <c9f24997-0112-8684-dc38-a6f8ba64c158@gmail.com>
Date:   Thu, 18 Apr 2019 09:30:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB4543A5CA46FBB3ACC9F3B3E289260@VI1PR04MB4543.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Robin,

> Hi Igor,
> 	Did you meet any issue with my latest patch?

sorry, but unfortunately I have no time to test it.

I have switched to PIO mode and continue other development.

Maybe later I will find time to test DMA mode, but not sure when.

Thank you for support!

--

Igor Plyatov

>> -----Original Message-----
>> From: Robin Gong
>> Sent: April 9, 2019 11:26>
>> Hi Igor,
>> 	Please have a try with the attached patches, and revert 25aaa75df1e6,
>> ad0d92d7ba6a , dd4b487b32a3, df07101e1c4a before apply. Besides XCH, tx
>> thresh should be set to 0 , now no failure caught on ecspi5.
>>
