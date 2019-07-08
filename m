Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7797C606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B20216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfGHOit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:38:49 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45329 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfGHOit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:38:49 -0400
Received: from [192.168.1.110] ([95.117.164.184]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAfMc-1hdwH01vQ0-00B2ME; Mon, 08 Jul 2019 16:38:46 +0200
Subject: Re: mfd: asic3: One function call less in asic3_irq_probe()
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <01f6a8cd-0205-8d34-2aa3-e4b691e7eb95@web.de>
 <20190707005251.GQ17978@ZenIV.linux.org.uk>
 <4b06e2fb-a0ba-56e5-b46b-98e986e6f2fd@web.de>
 <6e8eab5f-1f5c-b3dc-6b65-96a874ec2789@metux.net>
 <b116fc90-9558-8609-d803-7d8da2b66e0a@web.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <143cb102-f310-c3e4-a1fc-ac45690999fa@metux.net>
Date:   Mon, 8 Jul 2019 16:38:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b116fc90-9558-8609-d803-7d8da2b66e0a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wa7vmB3eJM2UpBn+wAPEzGkfKJ2qKOqgvGNbxbvku5a1wslOmVr
 FRpRQQLBz3PNGao7N5PClZR+gBakHaR05nUZdjrGoaFuNqz7uEGKC2Qrlzm7lOLzeU1ePyW
 JESsH2qmwEENE2vIu3mgj7H7W5Us79wtGNoLGSygMv/YsxlBg2b6jCOp01oQtwsFMjfXXrR
 2cqY1zvK7GbwVqubPP6CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oOuyiMjqq54=:25L/bs01Xm7tAAvobZsgq4
 T0SvS/gYqrVjQVAbfbL194m/LuZSNuXjkALOcPWXp3LcxYsMtvlYk97/tEuloZlunHIkVcxVg
 DQgLa06j3g3yryuIvINidsDpastN43LMrdCFf0QsdboV7+dYz2EGM/Z52PYs04DtRymoS3fJa
 OYTt5rWFIy1Fn1Ta1iINRemiZ/tqXXDJGIdDwwAPOqp0jJ1uzUA4aSilhm0XP3rPZH/An0pWq
 1qtb0OE90fsUSqBD/le9PnJvghPLNRNa0b6uQmIhyQjZREG3/qYndELaF4WZLeNtRJcPGmA33
 AaIQymTJ02n9dcRDWuawRP/GH+FIqH9Qpm6LqoOoHa0maINAWHvZDOt8BrUVi3THGdqRoK6lR
 fDYSNPZEJP7tgz7L9u9IqapNxD2YMRHGXwid3NJzfD7TpKoerCOiaC0N2X3MigcOG1LtTs02U
 P5Z++duQURUza8BDhzTuAl2iL2H3xD1qwJYnIZxWG7ElFiYvyXEOkpnOZYd9r8n/OJC8Kp3yE
 lYaR+lYKCZTF3xGYe3t8B/vzmNNBWtdA+RZjbeOU2ElHBor9NxcPpNWs1moksXfM55WtB8rbO
 xIKpKUi1S7uBIaTJpjcXfXL/iwMoLozuB5/xYyCMP+ZdJrCfPZibsv8HJNju+I0NmvGAmEbqf
 nV3tu0ZdD3cIrGFk9fjjOzZBmdbzh3nVPI7HS+TfMbsBjrndvNWAYUZSPwd+hwhn3hepx6G4L
 ixQI+cirM9pWIy2Bp4Lq7VuLztU5ra01VezabvxVZhud3USvjIGKa0ajzH9MV3+f8l/xNFWgu
 bl7xsddWrHikYOpWECGSLrHyxKTXR1awkV1IKqFJcfr4B4Zf0/d0oFnZdz+Q6jgz0fUrsuO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.07.19 13:50, Markus Elfring wrote:
>>> I suggest to reduce a bit of duplicate source code also at this place.
>>
>> Duplicate code (logic) or just characters ?
> 
> Both.

You could also complexity for the human reader. That's a point where
personal perception comes in, which needs to be taken into account.

> The code text size can influence this aspect in considerable ways.

It *can*, but not necessarily. I'd prefer leaving this choice to the
maintainer, as he's the one who finally needs to care about all the
code. Discussions about such choices tend to be pointless (personal
perception / taste isn't something that can be debated by argument) and
risks annoying people and waste precious brain time.

> I suggest occasionally again to reconsider consequences around a principle
> like “Don't repeat yourself”.

In general correct. But in some cases repeating a few words can make the
code actually easier to read (psychologic phenomenon - human brains work
very different from computers). This needs to be carefully weighted.

Theorettically, we could do this conversation with much less words,
using some purely logic language, similar to math formulas - but for
most people this hard to do. Therefore, let's make the code easy for
us humans and let the machines (eg. compiler) do the heavy lifting.

>> But that doesn't mean that a particular patch can be accepted
>> or not in the greater context.
> 
> Would you like to find the corresponding change acceptance out at all?

For particular change, I wouldn't really object, but I don't like it
so much either. Some your other changes IMHO do make the code prettier.

>> - it's not a technical
> 
> I got an other impression.

That's the point. Psychology / personal perception plays a big role
here. We can't deduce it by pure logic.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
