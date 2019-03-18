Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B755820850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CCHQbn6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCRKjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:39:32 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:57122 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfCRKjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:39:31 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190318103927epoutp0391d992261601a623fc26f11a93686e47~NB2LbzJrG2076120761epoutp03e
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:39:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190318103927epoutp0391d992261601a623fc26f11a93686e47~NB2LbzJrG2076120761epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552905567;
        bh=PjL2hVVhPVuXwXvMZXEyTZlIo/7px4FdHo2TaZroed4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CCHQbn6PZU/vXVZSwQ+thGlyU9fXpudFYh8Uso6vxcYGIWKgAE4OvrZbuC2U7i1Y6
         IYyRTG07zC70C+jE1QPzqk7V05MdqIOdM/3lIt59IO8FInqnC6Ia+40Bh8KD7rPO6j
         908gB7DM6hGhYppB9kKT0WDMRWIYOOsveKUdG74w=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190318103924epcas1p105f45b5fd04ba69a3caa2f293ba798db~NB2IMOlLT1398813988epcas1p1E;
        Mon, 18 Mar 2019 10:39:24 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.A8.04108.C557F8C5; Mon, 18 Mar 2019 19:39:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190318103923epcas1p3fca3b7d20671885240e8b7107f23dee8~NB2HfkYRj2195121951epcas1p3f;
        Mon, 18 Mar 2019 10:39:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190318103923epsmtrp2c229bc454b5f652b8d006672170f8751~NB2HcVyCI1397613976epsmtrp2r;
        Mon, 18 Mar 2019 10:39:23 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-1f-5c8f755cd7b9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.12.03662.B557F8C5; Mon, 18 Mar 2019 19:39:23 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190318103923epsmtip1ae1d711448ff268b38d4bd13b59989af~NB2HQFSOl1506615066epsmtip1S;
        Mon, 18 Mar 2019 10:39:23 +0000 (GMT)
Subject: Re: [PATCH 1/2] dt-bindings: extcon: Add support for fsa9480 switch
To:     =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        myungjoo.ham@samsung.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1cc29550-695e-a522-28bd-7bda3299aec5@samsung.com>
Date:   Mon, 18 Mar 2019 19:39:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190225165822.2770-2-pawel.mikolaj.chmiel@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmnm5MaX+Mwa1Gbov5R86xWlzeNYfN
        Yun1i0wWtxtXsFn8ON7HbNG69wi7xapdfxgd2D3WzFvD6LFz1l12j02rOtk8+rasYvT4vEku
        gDUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6Awl
        hbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBh
        QnZGz+4LbAWL+StuNZxjbmDcydPFyMkhIWAiMevIDbYuRi4OIYEdjBLzXveyQzifGCWeLdnK
        COF8Y5R49eYjE0zLn8dnoVr2Mkp07pjFCuG8Z5RYs+AyI0iVsICPxPwd81lBbBGBOIl5bZNZ
        QIqYBXoZJS5Pu88CkmAT0JLY/wJkOycHv4CixNUfj8GaeQXsJJ7emwS2jkVAVeLO2p3sILao
        QITE+6e7WSBqBCVOznwCZnMKOEu0npjDDGIzC4hL3HoynwnClpdo3jqbGWSxhMBnNoljexYw
        Q/zgItHy6R2ULSzx6vgWdghbSuLzu71sEHa1xMqTR9ggmjsYJbbsv8AKkTCW2L90MtAGDqAN
        mhLrd+lDLOOTePe1hxUkLCHAK9HRJgRRrSxx+cFdaNBJSixu74Qa7yFx9+IbpgmMirOQvDML
        yQuzkLwwC2HZAkaWVYxiqQXFuempxYYFpsjxvYkRnEi1LHcwHjvnc4hRgINRiYe3YUpfjBBr
        YllxZe4hRgkOZiURXnvP/hgh3pTEyqrUovz4otKc1OJDjKbA0J7ILCWanA9M8nkl8YamRsbG
        xhYmhmamhoZK4rzrHZxjhATSE0tSs1NTC1KLYPqYODilGhj7dZs7njL/lWtjuBN43vd113yG
        5NM3pwQdz+c6ErSucccvTxdfx9UaJlv+xbCxO8zyrFlo9uOxcrp7BPtV9WkblAWLb9SfK9J5
        yLrG2oylsO6jyuEFfv0KG2Klahl33WvLVtltnGY53e1Xftj8DVo/vr2OiZV8zG6nWX9qpeTf
        M2ziWUdVM5RYijMSDbWYi4oTAQ08n1S6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnG50aX+Mwc1OYYv5R86xWlzeNYfN
        Yun1i0wWtxtXsFn8ON7HbNG69wi7xapdfxgd2D3WzFvD6LFz1l12j02rOtk8+rasYvT4vEku
        gDWKyyYlNSezLLVI3y6BK6Nn9wW2gsX8FbcazjE3MO7k6WLk5JAQMJH48/gsWxcjF4eQwG5G
        iekLd7BAJCQlpl08ytzFyAFkC0scPlwMUfOWUeL2pE2sIDXCAj4S83fMB7NFBOIkJm7ZzwpS
        xCzQyyjxe8kSZoiO84wS32ZPB6tiE9CS2P/iBhuIzS+gKHH1x2NGEJtXwE7i6b1JTCA2i4Cq
        xJ21O9lBbFGBCIm7F1+wQNQISpyc+QTM5hRwlmg9MYcZxGYWUJf4M+8SlC0ucevJfCYIW16i
        eets5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIE
        R5SW1g7GEyfiDzEKcDAq8fDemNYXI8SaWFZcmXuIUYKDWUmE196zP0aINyWxsiq1KD++qDQn
        tfgQozQHi5I4r3z+sUghgfTEktTs1NSC1CKYLBMHp1QD46LDRyz2CQmeYtjLsF8vTveI6ES5
        FxXefSafV5VPfbLoy3Xjo3e0Pf+6VZyJ5Jx38/WLjXpGJQ13vRxtamtt/Ff4Vu1qWKBhEJVU
        eU2JVeyQaerJYwdF9i1XmdyVmKAtJfPix7GdJzzW3NvWqZBZ1F2YXfLr4QGzA4/VJedOduJq
        2xz3e8Wu30osxRmJhlrMRcWJACRCxgGkAgAA
X-CMS-MailID: 20190318103923epcas1p3fca3b7d20671885240e8b7107f23dee8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190225165901epcas2p44405070eb1a171aebb3c33fcbfac3b2a
References: <20190225165822.2770-1-pawel.mikolaj.chmiel@gmail.com>
        <CGME20190225165901epcas2p44405070eb1a171aebb3c33fcbfac3b2a@epcas2p4.samsung.com>
        <20190225165822.2770-2-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for late reply.

On 19. 2. 26. 오전 1:58, Paweł Chmiel wrote:
> From: Tomasz Figa <tomasz.figa@gmail.com>
> 
> This patch adds documentation for binding of extcont Fairchild
> Semiconductor FSA9480 microusb switch.
> This usb port accessory detector and switch, can be found for example in
> some Samsung s5pv210 based phones.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../bindings/extcon/extcon-fsa9480.txt        | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt b/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
> new file mode 100644
> index 000000000000..ebced7b18eb5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
> @@ -0,0 +1,21 @@
> +FAIRCHILD SEMICONDUCTOR FSA9480 MICROUSB SWITCH
> +
> +The FSA9480 is a USB port accessory detector and switch. The FSA9480 is fully
> +controlled using I2C and enables USB data, stereo and mono audio, video,
> +microphone, and UART data to use a common connector port.
> +
> +Required properties:
> + - compatible : Must be "fcs,fsa9480"
> + - reg : Specifies i2c slave address. Must be 0x25.
> + - interrupt-parent : Phandle to interrupt controller to which interrupt
> +   signal of the chip is connected.
> + - interrupts : Should contain one entry specifying interrupt signal of
> +   interrupt parent to which interrupt pin of the chip is connected.
> +
> + Example:
> +	musb@25 {
> +		compatible = "fcs,fsa9480";
> +		reg = <0x25>;
> +		interrupt-parent = <&gph2>;
> +		interrupts = <7 0>;
> +	};
> \ No newline at end of file
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
