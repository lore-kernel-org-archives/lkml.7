Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB0FC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B86B218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbfIIMhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:37:48 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:43601 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfIIMhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:37:48 -0400
Received: from localhost ([46.78.15.232]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MplPh-1iUryj3KQv-00q8v8; Mon, 09 Sep 2019 14:37:24 +0200
Date:   Mon, 9 Sep 2019 14:37:21 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iio: adc: hx711: fix bug in sampling of data
Message-ID: <20190909123720.qdew2c4evxd6dpyk@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Eojq1HDVaeAwkrHQiQU/HLlmOLn2Cs9VBHIwNAYCN2QsjHgH1hA
 vaZtKSjN3Nc2z6bUFFl+3Mg8tYqy7dq7fqIkugeNIOL2adp3Sf8QHG9KbLsyd7A0KKGQpHu
 EKdfW+xCKtdZEkmYiZjvQ1yg0mXNlYI7vdhI7odgWSFQmKjTsaLmgdRwarkPYwEqrpz7xbU
 MldZ4TA1ZRrELqRX87+IA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oi5vBwwBnbs=:ehiJoCvILHNBRnyYrxWn0t
 TmzNlSURrTNYRVdWzt95GAL8n0Psr1mXBgS+o9fq5ZCAbJsX026gP3woIVN7RzjO55b4TsKNv
 1o5gSufRt6/RLaxbzREATLOJTLvP/diwEAAkixxlbUlGOgRewg5lfpRGkoZAackDBudeCbzpT
 Zt5ebXC/a9fk/SSrJmczZxkUBakNSlWvXJ0i8/bt9/vFfFBG2ZNb9AIz9EJrdnRQvb8bH9hE4
 pqUCweKAtM7KVjATxaOlnWbB/2P6S+YquKLwWU4MLh+vGgaADrSlAlohuohyIFtClRs3JF+rA
 uflXakY4qHXa8JzlQDJTiMxGQNzENk0x+e1wu+GFFibYlT4ogOt3UbjNC1JG9VgOADt58x4jX
 oANsAADz38oiQK+Is/WTsI0BI69RyWRbKPftS7ay+i6QI3HLCE2ToyBoiDBqcY4UAEUwqQ0ox
 Rbx0Q0WgoxMzLVMRfVX0PkXntiqwVgQ6MqSvraW0LZa6HcjlVJrp4d6cSSjVdRTw3opnwHSqv
 TJuCG55HOvwM4KQABBJtMI8Z2CAVfsCrr5IjQgi+HSwYPMgI/SiWYPhmB+2rBxoHdBl4clIko
 0Ne8kLcpGN8cvddLjPnSZ6fx9UNkPYYG6xy8+tyEs+IWIbwP7/0ObLGHdsDmfv2MPSqhQ15f7
 8xgoIp/f+vREjMnUkR1DlA0gMV8fsEBZ+QEocV7EsaERjENKWzNKrrJjo1BB2dLbbZztlNSs3
 lS66yQlTXwh9upSYbC+ltm0iAnOEtLNWQ+r6fOJnJPKnMtHoxewx+fK7cMk1RYIySV9zN9G+m
 miuUly2VPk9Mb6w2ctYRyerfZiWBjzNMTqgbTKj2MWmP8mPRkY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bug in sampling function hx711_cycle() when interrupt occures while
PD_SCK is high. If PD_SCK is high for at least 60 us power down mode of
the sensor is entered which in turn leads to a wrong measurement.

Switch off interrupts during a PD_SCK high period and move query of DOUT
to the latest point of time which is at the end of PD_SCK low period.

This bug exists in the driver since it's initial addition. The more
interrupts on the system the higher is the probability that it happens.

Fixes: c3b2fdd0ea7e ("iio: adc: hx711: Add IIO driver for AVIA HX711")

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/adc/hx711.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 88c7fe15003b..0678964dbd21 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -101,13 +101,14 @@ struct hx711_data {
 static int hx711_cycle(struct hx711_data *hx711_data)
 {
 	int val;
+	unsigned long flags;
 
 	/*
 	 * if preempted for more then 60us while PD_SCK is high:
 	 * hx711 is going in reset
 	 * ==> measuring is false
 	 */
-	preempt_disable();
+	local_irq_save(flags);
 	gpiod_set_value(hx711_data->gpiod_pd_sck, 1);
 
 	/*
@@ -117,7 +118,6 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	 */
 	ndelay(hx711_data->data_ready_delay_ns);
 
-	val = gpiod_get_value(hx711_data->gpiod_dout);
 	/*
 	 * here we are not waiting for 0.2 us as suggested by the datasheet,
 	 * because the oscilloscope showed in a test scenario
@@ -125,7 +125,7 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	 * and 0.56 us for PD_SCK low on TI Sitara with 800 MHz
 	 */
 	gpiod_set_value(hx711_data->gpiod_pd_sck, 0);
-	preempt_enable();
+	local_irq_restore(flags);
 
 	/*
 	 * make it a square wave for addressing cases with capacitance on
@@ -133,7 +133,8 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	 */
 	ndelay(hx711_data->data_ready_delay_ns);
 
-	return val;
+	/* sample as late as possible */
+	return gpiod_get_value(hx711_data->gpiod_dout);
 }
 
 static int hx711_read(struct hx711_data *hx711_data)
-- 
2.11.0
