Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC5BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8785C218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfCVX0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:26:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfCVX0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:26:03 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7TXy-00040x-ON; Sat, 23 Mar 2019 00:25:58 +0100
Date:   Sat, 23 Mar 2019 00:25:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Lubomir Rintel <lkundrak@v3.sk>
cc:     Sebastian Reichel <sre@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 04/10] x86, olpc: Use a correct version when making up
 a battery node
In-Reply-To: <20190310162419.11861-5-lkundrak@v3.sk>
Message-ID: <alpine.DEB.2.21.1903230020270.2157@nanos.tec.linutronix.de>
References: <20190310162419.11861-1-lkundrak@v3.sk> <20190310162419.11861-5-lkundrak@v3.sk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2019, Lubomir Rintel wrote:

Subject prefix ...

> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature. We need to use a different compatible string for the
> XO-1.5 battery.
> 
> Previously olpc_dt_fixup() used the presence od the battery node's

s/od/of/

>  
> +int olpc_dt_compatible_match(phandle node, const char *compat)
> +{
> +	char buf[64];
> +	int plen;
> +	char *p;
> +	int len;

Please coalesce variables of the same type. No point in wasting space.

	char buf[64], *p;
	int plen, len;

Hmm?

> +
> +		if (olpc_dt_compatible_match(node, "olpc,xo1-battery")) {
> +			/* If we have a olpc,xo1-battery compatible, then we're
> +			 * running a new enough firmware that already has
> +			 * the dcon node.
> +			 */

Comment style:

       		 	 /*
			  * This is a proper multi line comment even
			  * if networking people use that horrible style
			  * above.
			  */

With those nitpicks fixed:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
