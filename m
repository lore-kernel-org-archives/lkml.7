Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C898CC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E6B2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfGONK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:10:58 -0400
Received: from ns.iliad.fr ([212.27.33.1]:49388 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730098AbfGONK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:10:58 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 4C7912017A;
        Mon, 15 Jul 2019 15:10:56 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 337A120080;
        Mon, 15 Jul 2019 15:10:56 +0200 (CEST)
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sean Young <sean@mess.org>, Brad Love <brad@nextdimension.cc>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Subject: DVB abstractions: filters and feeds
Message-ID: <207e17ad-7469-211f-8862-b08045e1183d@free.fr>
Date:   Mon, 15 Jul 2019 15:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Jul 15 15:10:56 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having a hard time understanding two abstractions in the DVB framework,
namely filters and feeds (P.S. I now see there are dvb_demux_filter's and
dmxdev_filter's, so it's really 3 abstractions that I'm not grasping.)

Specifically,

struct dvb_demux {
	...
	int filternum;
	int feednum;
	struct dvb_demux_filter *filter;
	struct dvb_demux_feed *feed;

and

struct dmxdev {
	...
	struct dmxdev_filter *filter;
	int filternum;


Also, I'm not sure about the relationship between dvb_demux and dmxdev.
Should they have the same filternum for a given adapter instance?

Basically, could someone shed a bit of light on these topics?


https://linuxtv.org/downloads/v4l-dvb-apis-new/kapi/dtv-demux.html?highlight=dmxdev#c.dmxdev
struct dmxdev : "Describes a digital TV demux device." /me puzzled

https://linuxtv.org/downloads/v4l-dvb-apis-new/kapi/dtv-demux.html?highlight=dvb_demux#c.dvb_demux
struct dvb_demux : "represents a digital TV demux"


Regards.
