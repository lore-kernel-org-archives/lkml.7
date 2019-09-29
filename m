Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AFEC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 18:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFFD217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 18:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OiuaOnoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfI2SSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 14:18:34 -0400
Received: from mout.web.de ([212.227.17.11]:51935 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbfI2SSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 14:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569781083;
        bh=4AvMrLTqbzy0Idt+PIgiT3OEZyJcUdGAXWRw4xDt458=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OiuaOnoHu54wgFSGL2wWHvYsDNuy08KQTFt5I8UIwaUz8HMTCdVLqAloQ3lcz63xh
         /8pF1Q+Iz23TEwU0cUEhANhyL5L9aI3NHPGxTeeOnwRy3Tt10mG6SgAlX5DXOAMERN
         FMK3Dw/6RfXfhYqkCRAeB8IdNTuODMzHHBdiysNM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.99.91]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1X0v-1hzJly2IdV-00tT5Z; Sun, 29
 Sep 2019 20:18:03 +0200
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
To:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Martijn Coenen <maco@android.com>
References: <alpine.DEB.2.21.1909291810300.3346@hadrien>
 <90cea5d2-b586-6f82-34dd-d7a812f57396@web.de>
 <alpine.DEB.2.21.1909292004460.4485@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <91b84fbf-0be8-85a2-616e-d3c463987cb8@web.de>
Date:   Sun, 29 Sep 2019 20:18:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909292004460.4485@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:lbyYnPfvZC0h6AfmYrRGclopsH2xKrAlKhNJrqcH2iqYkYnnZeD
 bFH6Z3cHaRvE3B0BXRC/Ij2xYpTVxAOj1hvPZldkOE4nfedSQP8yj74bWLqPZV1p0ljztun
 ZImCPk5kL7+P/lbtJV8hncIBwHQk7j1R8oNb9hN0Jp99bW2uCM5MnUJdg15Ferby02VnxbR
 vnx0p5FAoBRTabSyJIM6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LmktBG7wbRM=:XbhsXLt1PNBIl1iqPTcADw
 CF3DcHheRHNM2xy8EjhnVF5C2h+2ucXQq/7dWK7woKerqw+HoOdZ5LNSKmgCzD/9ZDmnYBB6x
 5KV+rv7J7WsDE0J1Q3Jzi8ms2Io5OaX7zoIvdTe47qTGa8MYanZf4mmj9Y3tMQnkQu6w88qHs
 pCICwT/HMKw1mloeI9GZ+2fw89FrIU7RLmqYo44cHiYJYMSF5bHTM1gP7viOAJKbbMEJlOfKQ
 lXIawjFxqgNXlu+YabcbYYrShYyh3nfU68rdEcpvF0fiW3F4tMGJUwllU7R5CwQMYX4KSEySY
 Q7/dbXlwRYXKAdbivZKyfN3LDJdwWQaw+X8d6OIXzuHD8Yw9pFtAwV65vslRMTIwNl7hqXh+u
 F8WERNQMN7UhYE8yFKjGfnYMIh+67JDfcGIDUQ+p3IHt4/F7PrvxemYPlxfaMWtCbrbJcCRg2
 vyXrxEatb+bASNqzCe8Iq81MwxGGPClgu3CCAhWg5Wx9XwR792EvUVuKE4UfZDYwV/KcsU2P8
 FtxabpY1xgfFh3YZF8UxezaGorP6OPc2eUI/QZxk+FENjnRXBDT8n4+c86DVhLBXf6rckbwQg
 AWwnPP2yFWOdnKawX0DJYH2TR7s5naS/MoAWywRJOM6Ipq1IInTOVgDQ5BlLf7dIHqG/x3ty0
 OsXopOwEtswogAcpb13HanJj3VXqLprtbB2PKGhaDs+AHw0QdG7hFHkeQUd5x+em0Kd+YJy83
 I92HOyjGpkBAGXDEbrx/tzVYPE/+WBatMEQsQo1lj5qT8kBix8EOadxhYrEeZpEslR9Md8J3z
 yVei8qRZqIrma4Lj6Y3lhYQ+Qs3+FCQUIY2796kx7HxgYousQ8eBFAQgEYKO9xBSRYdAtbjB4
 5E+SBzAZFOqMCCO7VQBkuX/XLZq++b5VHfnhV+ydHoKWnNYaxJtx2iHkVmGML+EPdoP2qs9yW
 XR/28DEChvq92CKxEmDmJlI0CxEyBd8yaiP0Vyh5btxossyWaEBTbZR9U81hoKVy1c/uvblp7
 WLaoDufp7oe8dxIagvv2CU2WsC/VMC47vmHgeNEMhiy3jMZDMIFFX93wSmTqGLjjTvt28Iv7+
 B7BPscGFD76IWWRqeykiIsFsFJa0sDJXg6WZWUeLh90SmyA+unUTGFzWPNF3YjRnqpa/rhIm6
 kveo8sHEMQnV++rzdEQJTub5RO8H0k6nElzAtIcjlgfJdoLh2WpWuKG8/DdBRh282uYEWn9k9
 lJWnId7caUTP4Thi/P96Ph7yxiywZdiumzCCdpy2jDfiTxq2EpKcAKk8vAxI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Coccicheck requires that all rules support the report mode.

I find this requirement not so clear while this operation mode
is reasonable as a default selection.
https://bottest.wiki.kernel.org/coccicheck#modes

I am curious how the software will evolve further also in this area.
Possible solutions might become more interesting in other directions.

Regards,
Markus
