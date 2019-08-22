Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34C6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E7D233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="E7/haOOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbfHVOva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:51:30 -0400
Received: from mout.web.de ([212.227.17.11]:44711 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387623AbfHVOv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566485451;
        bh=JJNw3yyI7LFjcQxSQaC2Dwh7+VMWL/aMrXs3yzs678I=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=E7/haOOojqJvt1y4CL5P/hXb2VGbhWXgdhuUd5fVONeM4kdaJOyqhlk/XGXhwEd72
         7unQMKQT1yKllSd/lFZ3wVbTb6dBBt++sDGAPirwitITIT/IVqKDiF3mm2crMka4nQ
         wGYeuDw3h/0gbAMNOADSM+usRzATNBJygTPyQg3g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.181.43]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQNma-1hok7z0Yiy-00Tj7H; Thu, 22
 Aug 2019 16:50:51 +0200
To:     kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        Li Rongqing <lirongqing@baidu.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] ipc/mqueue: Adjustments for do_mq_notify()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <6e9378d1-3b9b-e138-53f6-bc5683ac8b8c@web.de>
Date:   Thu, 22 Aug 2019 16:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UwA56m5d+nLxmCo7FtThSiUfdaO/tIYKyDa57OHKmeP6Dg1psQb
 vCS2J31SUG7ODvZjYXk2JGxx6j4qfpsVd0TGURoUO/r8+/sB49pw+9ed/fNKS7RUX1tOwTv
 VXbfOAdbSXYBbkl5PdZmtNWs7UgMW2hhteMJO8ERloF86Ce4/eMqV0XaBIP6elE8RyhYysB
 NGXI5svLEny1G3EMtp19A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ehrkp7VIAwM=:HELClc4fwit5GT3smweJuo
 w4x1v8YuBelolUOGcZZadJONNhcvFhZ13vl/V8ucI5rh5wOmdlhEG766g65s4LV9dVoTc/Q+f
 0PTRVadQDj5U7/wftSi+p2iVKlCbBcby2kO9wchr1L075L843/CtEHXwgJ5UtkgQ0uIuZ1x9y
 ub9cT6kynBx4t0LjVLrOlL462vzxlTlF3QzaB/GpsJcUE6T5RChekTuc80onrl8BueEEyHyIQ
 NfudW+pfvzNrIaJRvsWShYqpIJB6dm+xHSswmxdUXIeE1rkXxr1wGWMcvaXoyFEpbupixpsQk
 wnxFEf1E7PmRLHG0wmn6uAcoySennGRbmliVUPDFfFvKsnaNnIdm1/yAo2sMaeJT8uM0H/+2e
 L8uqrTrMkF5EkIJNrPhYyL8ZsSmQAZxr8XNwqNLLoj+BCgQOhn8igqeYvn+a9AsBHPcNmNbGk
 csVrxkEpSI7d8YwQyWiz6eEJcHYhd4hyWU3iZYH6HxkgTtFAPf/avx7/yZQE1pXaYmd3bb/X5
 OW8t5kpMRIxSjwNc/9mmG19qhebabMix1WwS9LkZNqIZpSQKerauQW2R5geR4JJGfQQaKWQZ4
 EY2FiDeUumAIhpC1WPRXXqXsPzb4+nvo/boacpXBOmTALw/mauz+eotrzkFcjUGdBRJTtaJSf
 HuPo6RuDu1Js/743InAOSwECmUzsvRPT/1xWiAXb/r2hmGsEb97H4E/RVms6uG9Nf+lpkrNfH
 MQcoq8i9FneceOG25AJdsjvDl6f1ydhM0DLS6fHCJ5sgqzF9lOGmXGMyq98KsMLuuuO34VXJ7
 P+0JvOgBbr89vWZmupoGZMdR4hUgSENMPYJxs/UhBc9FheBQZJ8w7M8lUhX//daek8WSZfAhA
 YzyVFZkN5H0CPMgLv/TJ+N5AknXTCxPYorRO9Lz2mYgzZVQz5m1pzqBB+f8iFS1/DKr766PxO
 i3yNUneXWXeZtvAZlXY9soH8NNUHpZkKxuhFaoTqVV3PIDNidsXctoNuiSsuKslnnjZ2F73Ac
 cNEZoPgYWJJTnIE9wh5qqYWARVdVBsCzanWiGqbIfRwKOBs3uaLVDkLYavx4ZFTmSTNhzz0T0
 7h9wKuDx3oN7aCTqqQ4+hDSnr3lnk92OvvY5HeKStRWvjQ1EAZenqghu2gfKZ4SkH7fHgIaJJ
 Wjsja9x3YfF0Zefq2Ngr1TRnPM/VZ0EDmKKVmGzOM5KQR4XA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 22 Aug 2019 16:38:49 +0200
Subject: [PATCH 0/2] ipc/mqueue: Adjustments for do_mq_notify()

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an unnecessary check before the macro call =E2=80=9Cdev_kfree_skb=
=E2=80=9D
  Improve exception handling in do_mq_notify()

 ipc/mqueue.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

=2D-
2.23.0

