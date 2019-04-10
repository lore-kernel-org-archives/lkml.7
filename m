Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A70EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086A12077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="iPRNj1KY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfDJJUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:20:47 -0400
Received: from mout.web.de ([212.227.17.11]:40369 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727226AbfDJJUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554888018;
        bh=2FYswxDKW9RjyC9nnuFAbcWwWRs0tTGJp9obytb1g40=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iPRNj1KYQ+n7aURaJxUGbca/RoZu4cOHMqihNnCSHaX98eLCJLI4uuXPB7QiYGC3k
         8K3UBlXBpTL+AoiqOoF2zy+XR/enqhRvJHBEQxAy7uTaPwxzBwZexqXCh03PbhzEh5
         ROTaS4ew58gnlns/s645gg/ldM05Ax129QTk92Xs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.98.93]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lo0ZA-1gh0VW09Um-00g4MB; Wed, 10
 Apr 2019 11:20:18 +0200
Subject: Re: [v2] net: xilinx: add a helper function for axienet_probe
To:     Wen Yang <wen.yang99@zte.com.cn>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <John.Linn@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>
References: <1554865035-8499-1-git-send-email-wen.yang99@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cb5657c0-e21a-0228-0638-0b41b423a812@web.de>
Date:   Wed, 10 Apr 2019 11:20:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554865035-8499-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jHb9h3UtyFkMr4ZSftIwD8Q0bvt8oZ+vFI5fETh9YzqCwlCz4o/
 mcxCJW7rzARPBS6llSKxsmVCHuS+RnrsyjCHIR1pChkW0k6o10RhEQBZlmP+vTGMfsoLi9K
 tnqXeLrw1TbYqjdnKQ3NPA6yGODhEoTi/HuELcliiJZaBuxzu1Sg4UJz09y8hm03ibZX1X3
 /rNLm57y2H3QqKEvO8J2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+KJDi6GXL0Y=:pgKxfarPMmbPy3wEPx9AxK
 Jg82uU7A6j6bc0u6B+5FZoydEau5srnEKzMjKDc9uDPMh4ySVxRFr2yjiwYz3/IBjorXkc9Cn
 wOTHP3Y4J2fKTI/anNvmOZEk7Y2z2J7i+l/v5oaLShS2Dhs56h/VZhoAcA6Q7Ew3Gl/FdARjl
 VoEO30jo4/ymJjWBkpzBti+0I6ki93d1vdIvNlzkht50mPe1D5nFqAeZj3Yakwqu9TkooJQCs
 O+kjSpiimXTRz7ZP6l1VgaviJHT7Qt3+on9ug95CFIKo4WBp7IvdfmeVBkV1OMI29Bt6jjCs2
 6GY5oAv2sEVCsvJ8V/9w/Smt5q2/jY3tLpuC4utV4f1bQU/kT4C+5+VmnuvHq8uKgGTVrlanr
 Cm7CbVqouRcy8xy3yRgxQtig3mZLuLH7B4diBnNAiWRihO9KuIvdC8vLfnxOs3H9N6L9w5qVx
 S1vUrhTq1fmUCpRYGE5wjm12sIQO6gb7Hz9WlEKgxavPU96kvTOISXeEcLJFLsDITVhSq87aB
 3KjTYVwrbrAPPTICozGqLuAeGj+ggVc/J3BWqk5Bta/Bu+we5Q8nLxKiuKbho1PpP/XVr97Lo
 f6rmSouA3S4qa3Swb7jLOOBWDa87NP9RbAxtw+jwhmjhOqb9JE6zE5WBBcHPjo3YYXjHE0UDl
 FpVf4C3+p9YF9WZQeTC9EORSu1GvEOzamiMMcJ7gFSA6S53exgpuOOM+HmEy39NS72naxSJO/
 oywe5JrurWTEYBAtGcUyKK9zcM1vyBPwHOuAM6l+HarBl8V5gLrp/ZlNJqIquZKy72yjNPYP/
 CBzlE8yBYyqinXjY0Nlr0DxXyv8i4QktG8lu1JhItefg2BosVtFbjMr3AjZEyxPFuCxDchQ8l
 B7/XBMqY+qBbsIG19tFm0Jt2HuSeo6j0Kig0Nlk3pPatEOHzcO8lVGZmUTFtqi8afod65XtG/
 XPU/mx3VvLw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The "Find DMA Node, Map DMA Register, and Decode DMA IRQ" code snippets
> in axienet_probe() are independent. Tidy this function implementation
> a little up by factoring these calls out into a helper function.

Would another adjustment be safer for the word =E2=80=9Cindependent=E2=80=
=9D
because there are dependencies usually involved between function calls
for such a software refactoring?


> v2: Massaged changelog a bit

Thanks.

Regards,
Markus
