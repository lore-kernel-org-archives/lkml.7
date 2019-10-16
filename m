Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90A4ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746A020873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391100AbfJPEoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 00:44:44 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59094 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389649AbfJPEon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 00:44:43 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46tKTN4W6Pz1rGRY;
        Wed, 16 Oct 2019 06:44:40 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46tKTN2mm1z1qvrr;
        Wed, 16 Oct 2019 06:44:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 1VfeJ8X47Ze6; Wed, 16 Oct 2019 06:44:38 +0200 (CEST)
X-Auth-Info: xwmaVoZ2F5eRtD1d1oRFGlQX+Mzrz5/g6FC4U/BJzf0=
Received: from [192.168.1.106] (unknown [81.0.126.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 16 Oct 2019 06:44:38 +0200 (CEST)
Reply-To: hs@denx.de
Subject: Re: [PATCH 2/2] misc: add support for the cc1101 RF transceiver chip
 from TI
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20190922060356.58763-1-hs@denx.de>
 <20190922060356.58763-3-hs@denx.de> <20191011064342.GA1045420@kroah.com>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <da8890e0-e727-ba2b-bc5e-faad327de4d8@denx.de>
Date:   Wed, 16 Oct 2019 06:44:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20191011064342.GA1045420@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Am 11.10.2019 um 08:43 schrieb Greg Kroah-Hartman:
> On Sun, Sep 22, 2019 at 08:03:56AM +0200, Heiko Schocher wrote:
>> +struct __attribute__ ((packed)) msg_queue_user {
>> +	int	type; /* CC1101_MSG_SET_ */
>> +};
>> +
>> +/* CC1101_MSG_DEFINE_CONFIG */
>> +struct __attribute__ ((packed)) config_param {
>> +	char addr;
>> +	char val;
>> +};
> 
> {sigh}

Sorry for that ...

> None of these structures are valid ones to be passing to/from
> userspace/kernel at all.  Please fix them up to work properly (i.e. use
> the correct types and such).  I think there's a "how to write a correct
> ioctl" document in the documentation directory somewhere, you might want
> to search for that.

Ok, the driver does not use ioctl only read/write, but the overall
question is, has this driver at all a chance to go into mainline?

I searched for "write a correct" in Documentation but get:

$ grep -lr "write a correct" Documentation/
$

May "Documentation/ioctl/botching-up-ioctls.rst" helps, so I convert
to use the __u* types, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
