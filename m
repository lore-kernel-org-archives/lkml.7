Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD162C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871FB24483
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfFDN7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:59:04 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:37277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFDN7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:59:04 -0400
Received: from [192.168.1.110] ([95.118.47.44]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N2Dgk-1gZ99F0Wxa-013hyP; Tue, 04 Jun 2019 15:59:03 +0200
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: RFC: use of_match_ptr() and conditional of match table declaration
Organization: metux IT consult
Message-ID: <293b771e-252c-d376-1347-1e6570758be9@metux.net>
Date:   Tue, 4 Jun 2019 13:59:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:udZWyoJrYZ44zOAntaBgdJjWFU+mmriA+Px9COjKpx2qEYsyPTT
 HDRBb20EHG/bCCZhHEmui9tcHA34ZGp8WW39pySt9PU6GUcYoJE3zVAR6jz30CyV5c0i5xT
 z2SI2Vgnenw7f8DctCruXoVk/H58FhVJwSLsUi2oa6HxIcIjgQcH77QSjrvmQxtE/RkUpyF
 DnTLOVkzT2CIWSYyEGr6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bGfkRfbFDeE=:gxyinuRReu0ha4ZO3q5urt
 zNz66nreAcPyzosIk7EQHkaStIK0vz68/0TwUB+IuK29uqnugX09+L3AEOjTO+4BMJY/pUKIZ
 H+ZKzOS03oZ79C9EKqJCR/MxFy6SAOBN56qRJDygEdmCi3DOa4y9KejGr6nwFIBCOrIU8yMwP
 qJ8RwZSxKH3HRmrF1IW+vIO4y5lUMLkoxXuDzEolRJGLcECe7tpv+BeBoqDPitXwUSCe4q5hO
 wXFDXtCUA8TJpMy5O93B2NrvcTccFClMwu/KVoIpW5Cx3P/PISXCfu4v8jVRNtve1TidkFjxT
 Ox+H9u8OFC+zqahoPPLgkJIyIeFCF9+JnU+J+/huxLGGwT6e8QIGSOqgixruyCdLizNi9jfO8
 4ryvEA8J2nJItCL0I90elqmAUl5AvS9wEhb8rb6mMku7SwUrFHrTRH/09TsHX0UmgJ3dURJ8Y
 jEARHzwoFPHyqIVvPZE+stLyXdBMrl/1tx89QfA9S+rlwsF0UWgmNRkFKhVG9gmd3XLPOp4pD
 PY7ivVu7f1DRaKbIzfD91yLVXcwLZlpBzBqklwvTAUwl1WiwtKZOY8S5QuKoED05uuXPJQkUo
 xKi6vRkddEqjCnBM6ROkLFKHKkXky/8KwFIhqXsnqd6JuvMOExJXr7bX7yo/9AJ1Uwp4OrABr
 kjr0OJAc6q1n6+2pu32cZZfXGGBObXfzaOVbxnB1EjZYSJVYX4CA8w1w82/7BcpgiPCq2RHpp
 U1L1VD8GMZGBoLq4BxykkupC6In5rG1Dobvqywsvz0CPMZN+vTOpnziTRs4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


we have a dozen drivers that can be built w/ and w/o oftree support.
In those cases we need conditional compiling (check for CONFIG_OF).
Some already use the of_match_ptr() macro, others still are cluttered
w/ ifdef's.

I've converted some of them to using of_match_ptr(), but I'm curious
whether we also should convert all drivers and make this the standard
policy (also let checkpatch check for it).

Most of that can be done automatically, few cases need some manual
intervention. (already have queue here, which just needs to be a bit
sorted and posted to the individual maintainers)

How do you think about this idea ?

Are there some good reasons for not using this macro ?


By the way: I'm also experimenting w/ using a macro for declaring the
match tables conditionally, so we can reduce the boilerplate a bit.
It then looks like that:

    MODULE_DECLARE_OF_TABLE(foo, { first entry }, { second entry }, ...)

This macro declares a static const struct of_device_id
array by given name, initializes with the given parameters adds the
sentinel (so no chance for forgetting it anymore ;-)), and finally calls
MODULE_DEVICE_TABLE(of, foo)  - but only if CONFIG_OF is enabled.

What I haven't sorted out yet: what exactly to do in !CONFIG_OF case ?

a) if we're always using of_match_ptr() - don't need to do anything
b) declare a static const *pointer* variable, initialized to NULL,
    so the variable name can be used as before - hoping the compiler
    is clever enough to just optimize it away.

What's your oppinion on that ?



--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
