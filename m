Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDB8C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5E72089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbfG3P0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:26:03 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50754 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbfG3P0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:26:03 -0400
Received: from [167.98.27.226] (helo=[10.35.6.253])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hsU0k-0000og-32; Tue, 30 Jul 2019 16:25:58 +0100
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on diagnostic
 routine
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730141935.GF4264@sirena.org.uk>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
Date:   Tue, 30 Jul 2019 16:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730141935.GF4264@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2019 15:19, Mark Brown wrote:
> On Tue, Jul 30, 2019 at 01:09:37PM +0100, Thomas Preston wrote:
> 
>> +	struct dentry *debugfs;
>> +	struct mutex diagnostic_mutex;
>> +};
> 
> It is unclear what this mutex usefully protects, it only gets taken when
> writing to the debugfs file to trigger this diagnostic mode but doesn't
> do anything to control interactions with any other code path in the
> driver.
> 

If another process reads the debugfs node "diagnostic" while the turn-on 
diagnostic mode is running, this mutex prevents the second process
restarting the diagnostics.

This is redundant if debugfs reads are atomic, but I don't think they are.


>> +static int run_turn_on_diagnostic(struct tda7802_priv *tda7802, u8 *status)
>> +{
>> +	struct device *dev = &tda7802->i2c->dev;
>> +	int err_status, err;
>> +	unsigned int val;
>> +	u8 state[NUM_IB];
> 
>> +	/* We must wait 20ms for device to settle, otherwise diagnostics will
>> +	 * not start and regmap poll will timeout.
>> +	 */
>> +	msleep(DIAGNOSTIC_SETTLE_MS);
> 
> The comment and define might go out of sync...
> 

Thanks, I will remove the 20ms but keep the comment here.

>> +	err = regmap_bulk_read(tda7802->regmap, TDA7802_DB1, status, 4);
>> +	if (err < 0) {
>> +		dev_err(dev, "Could not read channel status, %d\n", err);
>> +		goto diagnostic_restore;
>> +	}
> 
> ...but here we use a magic number for the array size :(
> 

Thanks, will update.

>> +static int tda7802_diagnostic_show(struct seq_file *f, void *p)
>> +{
>> +	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> 
> We neither use nor free buf?
> 
>> +static int tda7802_probe(struct snd_soc_component *component)
>> +{
>> +	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
>> +	struct device *dev = &tda7802->i2c->dev;
>> +	int err;
> 
> Why is this done at the component level?
> 

Argh my bad, a previous iteration required the buf and component. I missed
this, sorry for the noise.

Thanks for feedback, I'll go back and tend to all of this.
