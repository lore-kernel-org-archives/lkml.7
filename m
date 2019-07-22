Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F8AC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023F721E70
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfGVIN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:13:59 -0400
Received: from ns.iliad.fr ([212.27.33.1]:42458 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfGVIN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:13:58 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 60C28206AA;
        Mon, 22 Jul 2019 10:13:56 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 4269B200A6;
        Mon, 22 Jul 2019 10:13:56 +0200 (CEST)
Subject: Re: [PATCH v3] media: dvb: Provide 4 devm variants
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Sean Young <sean@mess.org>, Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <068836c7-a116-7e6f-cbb2-f2176fbb9a38@free.fr>
 <c7a7798b65e38355230d9ee235a3f8aa331123ca.camel@collabora.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <64344008-4077-9948-4482-0878279b50e8@free.fr>
Date:   Mon, 22 Jul 2019 10:13:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c7a7798b65e38355230d9ee235a3f8aa331123ca.camel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Jul 22 10:13:56 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2019 17:02, Ezequiel Garcia wrote:

> On Thu, 2019-07-18 at 15:03 +0200, Marc Gonzalez wrote:
>
>> Provide devm variants for automatic resource release on device removal.
>> Makes error-handling in probe() simpler, thus less error-prone.
>> Once all resources are devmanaged, remove() is no longer needed.
> 
> I think it would be better to add this API as part of a series
> that also uses it.

I have an outstanding RFC for a new driver:

	https://patchwork.kernel.org/patch/11040435/

Locally, I've updated the probe function to use the proposed devm functions.

I was mainly hoping to get initial feedback from the maintainers.
1) See if they're OK with devm APIs
2) See if they're OK with the way I implemented devm APIs
3) See what's missing to get an Ack

static int tsif_probe(struct platform_device *pdev)
{
	int err, virq;
	struct tsif *tsif;
	struct resource *res;
	struct dvb_frontend *fe;
	struct dvb_adapter *adap;
	struct device *dev = &pdev->dev;
	short num = DVB_UNSET;

	fe = dvb_get_demod_fe(dev->of_node);
	if (!fe)
		return -ENXIO;

	tsif = devm_kzalloc(dev, sizeof(*tsif), GFP_KERNEL);
	if (!tsif)
		return -ENOMEM;

	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tsif0");
	tsif->base = devm_ioremap_resource(dev, res);
	if (IS_ERR(tsif->base))
		return PTR_ERR(tsif->base);

	virq = platform_get_irq_byname(pdev, "tsif0");
	err = devm_request_irq(dev, virq, tsif_isr, IRQF_SHARED, "tsif", tsif);
	if (err)
		return err;

	tsif->clk = devm_clk_get(dev, "iface");
	if (IS_ERR(tsif->clk))
		return PTR_ERR(tsif->clk);

	err = devm_clk_prepare_enable(dev, tsif->clk);
	if (err)
		return err;

	adap = &tsif->adapter;
	err = devm_dvb_register_adapter(dev, adap, "tsif", THIS_MODULE, &num);
	if (err) return err;

	/* Not sure the diff between filter and feed? */
	tsif->demux.filternum = 16; /*** Dunno what to put here ***/
	tsif->demux.feednum = 16;	/*** Dunno what to put here ***/
	tsif->demux.start_feed = noop;
	tsif->demux.stop_feed = noop;
	err = devm_dvb_dmx_init(dev, &tsif->demux);
	if (err) return err;

	/* What relation to dvb_demux.filternum??? */
	/* Do I need this object?? */
	tsif->dmxdev.filternum = 16;
	tsif->dmxdev.demux = &tsif->demux.dmx;
	err = devm_dvb_dmxdev_init(dev, &tsif->dmxdev, adap);
	if (err) return err;

	err = devm_dvb_register_frontend(dev, adap, fe);
	if (err) return err;

	writel_relaxed(TSIF_START + ENABLE_IRQ, tsif->base + TSIF_STS_CTL);
	devm_add_action(dev, stop_tsif, tsif);
	INIT_WORK(&tsif->work, handle_pkt);

	return 0;
}
