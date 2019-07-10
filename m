Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62DFC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7BE20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XRoYyZXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfGJJZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:25:18 -0400
Received: from mout.web.de ([212.227.17.12]:54951 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfGJJZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562750690;
        bh=UWQsBYlELnAYysk2mtM7AdDfEOErIPJ0ROaaHxCVQxs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XRoYyZXYDivkNcB/t/1j7EiIQApsYPOkhM/geeTahr2vEQEADhDHgnHBQq8Yc6p/L
         YJko79Jp5XLc/ZhOI82urXCnKKykSMZmBtNxuKPMVazdcJ891WPv5IGc5xrCR3U1WU
         TJNyNwUvsvJZyTR+0DO8hl3lmTZ5+Bd2C9N/PRkc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.42.76]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzsGF-1iXj3B1Cqp-014zk9; Wed, 10
 Jul 2019 11:24:50 +0200
Subject: Re: [1/2] powerpc/83xx: fix use-after-free in mpc831x_usb_cfg()
To:     Wen Yang <wen.yang99@zte.com.cn>, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Kumar Gala <galak@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <201907101533443009168@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ef968d9a-785e-dbf7-dfe6-9572fc241e63@web.de>
Date:   Wed, 10 Jul 2019 11:24:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <201907101533443009168@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:u8YF1F7kU0eryeuNCAgxxNLtq1skRg8kO+bDl9Qx1VNi5KbWU52
 da522RyNmIHaH5nwXU4VySQbrXiQ90rR7mAg65Dca2oSG6TJVOIyckD5vPH27HsvPNzpqtF
 K2G+GKRzevvkWBpuVT0TH6PwMTre/wxnDnrtvhHFiOVfnKs3eNH5pttzQ707WRdLo7nTS0X
 8Tgp8R/Oakl9JGYopBZKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jVmT6SyvKd0=:jEbVcml8nJtdSC97HCysHC
 SW+yUsScvjRFJEQi6t22gIrim5WE5ffuwlLP4L5LUvN37lttkAAC4QoNrPdX6jwNb/8qsWQtF
 /w3Xer4ieL4obybJDnQ567SvRdJVAqB9SutbrNDwW8ireuR3/7ODd9nlxgGgGTjNNLeHQmhnb
 3lSj0Y0oj8Fo8JHp7rH/dibh+FO4sAGJrm7sfg32p+MdRknp+dwwyqIh1VXnJtDyGiMh1LW8N
 VBdhOaVMepRmEV8Z/qLZCzUgkF8U133PY021jG+b6ysDM3ov1swSIhv8Mie92oELoisOmls7y
 iV9MVUqpTXs1hayQIDtf6K8ma4yc9rD2A6ke7W4G/HWByQiuiLQGbZTES8UoKspqjwVLDNQ2Z
 FsInyzcFecqOsTJa2dEDRZsk95u0F51nSFSFXVOHf1Q+i1n9MOer3VQWPsYloCyir8HvcJy/h
 rErpqjY4+pQWkeU/jB6sfJK3T9IpEnD+kppalZdKjRQnph95evGKn2QI3g59bCi4RWorrC3QB
 dJRXmoqx7+veiFdHYzAyJig8K62Ax18/hZvUujdVT9u9GWLrWWDS7m2hcbWkpTCPtZch2HSTV
 xD6MRI8+Hj+vlz/lx2oay5mrZIrdahxV1Jdc7aAZBRlf3Wz2XnKc+FFfVnKgAxpINYzgndqx2
 +P+OOM2ZbGNHY+AF4kOnG3e22vJT9jxhqBK6rnV76GthSrjgJc+Z7w4Ugl0Fl+wSBd5QvHdM5
 sUb5zFqhk8Td6ui5oSYMx/HrAeqNkrEEk9xOxGI/pGIB4RKXYQXA/LLC3gSW7LAi8zUW4PrQF
 d3gqRtAXr9gGo6VdgKrGi5C+arvWoTwUEI/J3Grl89mRTPd5lKtjMhMIMpR96H30c4qgwhym2
 ETpaC/1Xk8QkUc8zOmhRDWWT+biYg9xtEjvCd0t7iD1wuyNNjQXyFRUk2o2yOxRac8XoQNOwB
 IddJQVb0Y/9AbpezJ0DMga4ZjQk7j/sCIhREQ0LbxgLeCGLsCu+mLfa5O5YmiOdUB2ICyyRFd
 vY9rOwYYPMn7aEcJbDkFUnFkSFZiKKfJPevIgJv5gMOe2tzNgvsitt5Bs93SpkJsftsUSwd8j
 W/JNwrvn2nQvJvY1CwMVgdNGyT2F6s74ugX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> we developed a coccinelle script to detect such problems.

How do you think about to give any attribution to this development software
in your commit descriptions?


> After a period of testing, we will send it to the LMKL mailing list later.

I am also curious then on how this area will evolve further.

Regards,
Markus
