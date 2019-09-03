Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CA7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED448208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pgwVhDMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfICQJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:09:16 -0400
Received: from mout.web.de ([212.227.17.11]:40543 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfICQJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567526632;
        bh=/nekiW6MnMYef0+et4HGmSzRulN/vr7UdPk6serwXNc=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=pgwVhDMqYYUoIpCyIDpIKZ3HAA2OsJ9b4yNZZYxTnaIA+cc7WWSDC2+zNR3UPinul
         +JGH6WtWsf/OOYkejDsgAUPpu2GVy3v5NipIuagnkqDr10w6Jm0uqumI6ZL5OWA06+
         8xqlPCU0DJw5zToV7CDZ2GIfawO4GH3Mi7+22R6k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXpZD-1hhvEV0w6R-00WlO9; Tue, 03
 Sep 2019 18:03:52 +0200
Cc:     Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20190726101447.9153-1-baijiaju1990@gmail.com>
Subject: Re: [1/3 v2] ocfs2: Fix possible null-pointer dereferences in
 ocfs2_xa_prepare_entry()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, ocfs2-devel@oss.oracle.com
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bd4ce5e6-9803-be94-5004-97beeee64c6c@web.de>
Date:   Tue, 3 Sep 2019 18:03:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190726101447.9153-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:DQpW/47ntw0GSyJSERN7BolyMXIlBN8A5W/qcydme1j9ToNC1Wc
 UuJc8oPbtK0Bvq7TeERRV9SMjCEp5EuBGLodlqRPkJe4ASPmlbpGBL3cIGvJNzn14/cdxHK
 C8TV9bOSL6bt8S8R3U970KAccHyEuOaP90KVYtWOohGx5erxP/FAiM0zE+eBaaGzJVmeg+i
 pKnyiHIkEsnTg36rYdrUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l30lEsAd2OA=:l68jQFc4hyVLhuxV12UVtV
 6MfbysOHSQxs8ESvVUCfEJ6HSCxKZRgdz0IrlmIhStvSq/lTcvcyyIeG5ZOqVHE6OQjwpaoQH
 4CctrdjBjkDhBS1l1Sv4La9mIlyMckDpDMgtdD9n5GivrmjMgmWxMk4LVPJS6hZFQeWgdHiGr
 JMKC8PSLupWH+5jSGYv3WpArgSD6tRHLKLKrtNlhYTcL1D0iPfA/94I2+IhEXAwR6G/r2Jf3L
 bU/4+w0mmzvJIiljWbtJky18Mg27z8kyKOMVaDrQGBDACAf1zElE/AORpvuA5o2rp38l6Hmr0
 Ff5KC/96yNyJnZfHj4AILTkf8fgOIBtoW5MTeqPCkQT6swxlwp57hREWfqWEDZDnp7eCZvrcX
 4zzRWs8AE0IG9lIvzlLzeJf/ZwbajJpmUTLlRNh9kz/aspLQduMJPrhERPp/Jg5aO5+XmAz/W
 CbNnuNChpo3EOpWvXuZqSAKhX8c0v0y2ApkosNGOHOARfmEDo4738ZhBvVQFit9y1Wod+ToiK
 dg+ssxGJnJQGDlVLy1yUfZh4kdemnIJ6qBRyKfHmz5ODTrJSoAFLq8nyU3BZ4a9WDuz3R6R1r
 0Prw7hojePoDzZ7lkmMpxWH2uCX7VJTsKxRsasLGpvD5xRqwor3uBAbHriOIMeyhLUFD3IPfe
 adVx9RcswC7l8WrH2cpyF7SQJP4bmStYda1UiRrJn87pbVaiXjmJMmo4/9+O0RsphBcZmVR4g
 KOphpE5VhmaPWbIFIv/SnuBLM/ff1z5cO4kpP2zZqM4/7XTta8hTdZJ5F5bD8cmKHy6pcI+y1
 FmCwHLPV+hK30hwLBkF4PDgyMjsG8YQi4PyZ1kBPSBUw1ER4rLVXWpjyUZm9bmVsGWjKosuQ3
 KGFdHEFXrpli+20VTWgVp65TsK2dBvPamOSTxOjWlipQI/5MPLrRHpJE00SntEVg8QYbcDx1Q
 c/pDR2yNlSBgovKZm2Wmt7F0TDu3+JDLR9UnknTKsjdx+D7ZtFKHMRr56qc81krdEOXC93r6J
 qOwTPfKgXXliCtyeb58Vh3951s2853hY06tZRRqTV7IW3h1xJRh8oR0vLZHW2MNvgVuqbxk2d
 ol1HFn0cHSK7wXLoLfZmKfjTgHSEOs+qoMnfsz+Io9GwJVh7AyDI1sERcnhsBH34N7WmHoc4u
 LYrRgpAcQSJuPsfwExi3bjzBRvtbsAQmyiQOnf6Tuu6AvBL9hSnNyruJ3eoMvbl9J7vWg+xVk
 D75ITbUMswDSKsI66
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> These bugs are found by a static analysis tool STCheck written by us.

Would you like to improve any more commit descriptions also by
adjusting such a wording?

Regards,
Markus
