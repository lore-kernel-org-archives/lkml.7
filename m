Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E3C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE1B217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfGVRXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:23:13 -0400
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:41475 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728233AbfGVRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:23:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9E65B100E86C5;
        Mon, 22 Jul 2019 17:23:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: walk80_1ab20649d4030
X-Filterd-Recvd-Size: 1884
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jul 2019 17:23:02 +0000 (UTC)
Message-ID: <f7b1a46569a7208eb2be3b5cc3432b0aa97fc3ee.camel@perches.com>
Subject: Re: [PATCH 2/2] HID: core: only warn once of oversize hid report
From:   Joe Perches <joe@perches.com>
To:     stillcompiling@gmail.com, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 22 Jul 2019 10:23:00 -0700
In-Reply-To: <20190722163642.10417-2-stillcompiling@gmail.com>
References: <20190722163642.10417-1-stillcompiling@gmail.com>
         <20190722163642.10417-2-stillcompiling@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-22 at 10:36 -0600, stillcompiling@gmail.com wrote:
> On HP spectre x360 convertible the message:
> hid-sensor-hub 001F:8087:0AC2.0002: hid_field_extract() called with n (192) > 32! (kworker/1:2)
> is continually printed many times per second, crowding out all other kernel logs
> Protect dmesg by printing the warning only one time.
[]
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
[]
> @@ -1311,7 +1311,7 @@ u32 hid_field_extract(const struct hid_device *hid, u8 *report,
>  			unsigned offset, unsigned n)
>  {
>  	if (n > 32) {
> -		hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
> +		hid_warn_once(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
>  			 n, current->comm);
>  		n = 32;
>  	}

Is this papering over an actual defect somewhere else?
Trivially, this could use "%s: ...", __func__, ...


