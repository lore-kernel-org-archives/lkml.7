Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5872C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0E520693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389887AbfGRJiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:38:12 -0400
Received: from ns.iliad.fr ([212.27.33.1]:43780 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbfGRJiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:38:12 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 99220205F8;
        Thu, 18 Jul 2019 11:38:10 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 82044205BC;
        Thu, 18 Jul 2019 11:38:10 +0200 (CEST)
Subject: Re: [PATCH v2] media: dvb: Provide 4 devm variants
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Sean Young <sean@mess.org>, Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <568760ff-08d8-6e7f-df35-cf76d4fcf945@free.fr>
Message-ID: <effb2781-8293-925a-0134-e071b3437581@free.fr>
Date:   Thu, 18 Jul 2019 11:38:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <568760ff-08d8-6e7f-df35-cf76d4fcf945@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jul 18 11:38:10 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2019 10:56, Marc Gonzalez wrote:

> +int devm_dvb_register_adapter(struct device *dev, struct dvb_adapter *adap,
> +		const char *name, struct module *module, short *adapter_nums)
> +{
> +	int rc = dvb_register_adapter(adap, name, module, dev, adapter_nums);
> +	return rc ? : devm_add_action_or_reset(dev, unregister_adapter, adap);

Doh! This is incorrect. (Face palm) Will spin a v3.

Regards.
