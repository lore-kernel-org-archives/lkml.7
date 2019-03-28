Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43EBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699672075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="siWVHLHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfC1A4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:56:51 -0400
Received: from owa.iluvatar.ai ([103.91.158.24]:5256 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfC1A4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:56:50 -0400
X-AuditID: 0a650161-773ff700000078a3-6b-5c9c1bce2c61
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 58.CE.30883.ECB1C9C5; Thu, 28 Mar 2019 08:56:46 +0800 (HKT)
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1553734606; h=from:subject:to:date:message-id;
        bh=46zmaGG8iwHHhYFuTWrHo6yN/24AMraaFTa5J1LagUo=;
        b=siWVHLHjnZZt1Gpqap/2TQ+Mqjfr2Yoc/+w8BuFFq13WRBHEKMtiwdwX7M9kDlC1hUwb0m0LQo4
        aiIGUQRPoLF5gROny95mVBd+Wrijdf9MhYbqiuUr/q0iHrbe6t3j++akYq11ew2RE9izUPWqShYb5
        FPjKW5xjhBXRZAobrl0=
Received: from hsj-Precision-5520 (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Thu, 28 Mar 2019 08:56:46 +0800
Date:   Thu, 28 Mar 2019 08:56:44 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] trace/page_ref: print out the page migratetype name
Message-ID: <20190328005644.GA3250@hsj-Precision-5520>
References: <20190327050937.5395-1-sjhuang@iluvatar.ai>
 <20190327092422.3cf2c7a3@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20190327092422.3cf2c7a3@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXClcqYpntOek6Mwa/TchaXd81hs7h0YAGT
        xb6OB0wOzB4t+26xe7zfd5XN4/MmuQDmKC6blNSczLLUIn27BK6MG6+3sBU8ZaloPnWNqYHx
        HnMXIyeHhICJxNGbr1m7GLk4hAROMEpcm7ORFSTBLKAjsWD3J7YuRg4gW1pi+T8OkBoWgbdM
        EjPX/IJq+M4osX/OdXaQBhYBVYkpD84xgthsAhoSc0/cBdsgAmS3LHjOAjHUTOLJjTawuLCA
        h8TH/h1gcV6gePu6w2BzhATSJPbeO8oIEReUODnzCVgNp4ClxOQ1b8B6RQWUJQ5sO84EcpyQ
        gILEi5VaEM8oSSzZO4sJwi6U+P7yLssERuFZSN6ZhfDOLCQLFjAyr2LkL85N18vMKS1LLEks
        0kvM3MQICfHEHYw3Ol/qHWIU4GBU4uFVyJ8dI8SaWFZcmXuIUYKDWUmEdwX3nBgh3pTEyqrU
        ovz4otKc1OJDjNIcLErivGUTTWKEBNITS1KzU1MLUotgskwcnFINTPxHTqzRYn4jVSrIa/kn
        aSPHFfbEqNQHMU29Gmq17kcXn59qPMmfc6Lunh9HDY0itNkX3QzbN79H8ukCiZSLNbFlutql
        GbMkhO68DJny+M8PjfcPf1g9Ul4pKJW9+f8L+VfZh73n8aldP9MsGnUmrkVoQg3DbalqmePm
        z6aYWp9a5njm/Jn67CdPpe43B1+YMPUur9205etXTyhr37WdfYVHa+4Xq495AUd+dV8xvmK6
        +gBPd0PgZ61wVYvY/z8OH79z/7WsCkd/g+qrYuHbL87J5RT0npI/Ms3v65kn1w9fFTotM2eL
        7NnFf47W7ru161a2dyTHk2mpnL+7ilbG/s1ads1jz/Tz9v7yDlcabjsqsRRnJBpqMRcVJwIA
        NXsDbu4CAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 09:24:22AM -0400, Steven Rostedt wrote:
> On Wed, 27 Mar 2019 13:09:37 +0800
> Huang Shijie <sjhuang@iluvatar.ai> wrote:
> 
> > Print out the page migratetype name which is more readable.
> 
> Except that it breaks perf and trace-cmd, as they wont know what a
> migratetype_names array contains.
> 
> See how writeback does it. Which would be something like this for you.
> 
> /* enums need to be exported to user space */
Thanks for pointing this...

I did not notice that it will breaks the perf and trace-cmd.

So please just ignore this patch.

Thanks
Huang Shijie
