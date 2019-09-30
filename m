Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E18EC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 06:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA1B2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 06:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XBHLn+Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfI3Gzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 02:55:32 -0400
Received: from mout.web.de ([217.72.192.78]:38605 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfI3Gzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 02:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569826522;
        bh=+3E/INNc/nZJwNdJLcPAZwGiWdqqBKAEARv1mFvBn1w=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=XBHLn+Q2bUoxfl6m7U8LwOAaoereWzFuqLX9CRAIWP61PQob0/EOO1eCU/sarsR5m
         3q99D103nW0/VfOGeo6sNUQmbQ+Dl5d6wsb49q+WS65+NhJ8wY01hMH9ztMyddYo0W
         xqdJGQIRjE1rbE9TQdxi3n5E5yN3n57zu4VOcDcA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.97.105]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LeLKb-1hmuMW3DRN-00qC1P; Mon, 30
 Sep 2019 08:55:21 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190930024147.25243-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] usb: dwc3: pci: prevent memory leak in dwc3_pci_probe
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-usb@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5f21ff8b-0cd2-5442-7d8b-f31b0f5dcdfe@web.de>
Date:   Mon, 30 Sep 2019 08:55:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190930024147.25243-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P+OGt6N+0QX9QcBfG9fpEPvI1r1TbI5LAftzqB3RikkON4+3hkS
 iHxzeaEga9e8WcwDnSbg5UWeXww+sQqLdQFByYcAWXhRYpWAgj8cfawXTh6JeqpNuSlae6+
 dvIhInTTKHsPbDhctwBKRDUKZ8ADFVy7hrIdVJUhKbrLhTIi9s4gxeWo+M7gDRt2OQ0RdCL
 gN0RMTcPMBRZ7Su3WiWmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r0EUch90hOQ=:JnE1MHNSBzIR4Lal1H6hxy
 j3Nm8AmAByGr2mLdox8fHm6r1gdl2rsd6jgtsoM91cnaP4zPR+OQmlAolGFOGscENGcRAXum5
 6xzhOIgd5oAD7LM10t6O1GHi6lQcPsRZwuN+4eFie12pb5JeFJIyAUL4YJ9RcXi8X80nPo4vj
 FyoWA34OVANMKXgGHb8l8htmoM5l4BWGVLfGqsRuYOru3CgAQd7EtTw+dlwI+cvpRyma1HuEe
 hY88+ICF7ZNN4qsO0EepJW+Sx0IXu4HdO3MgJR/8mDF//bcuVHMiXINwE9NNtEM7ehqcEDedl
 Vx6F75U3Axbh2hnGIWPetTwzN9OZPZ8AbbN1VEQqzTytWRPDdp7XoHij2JKNcwloTkp+lg8+J
 9d8Q99LiwSrzA8mz6+AayFFE8LmwGDlCwFp+5pa5OmSJsQTu9V1aVJbA3yOmsEqJjwZjiuUrL
 VMapsvzeJ1IZoXbTk9KPExPOQryzcA66ek9WgF/ZCg+Y/XqiW8qKCMQKFcgCc0MTu3GEp8TCb
 8yUReYbMbS1Ti4MLm0gff+0G/6PMFI0vllUCGvGFGopiKS0Oh6jvsddMaRmeDE1hd0VQWN3Oh
 2uzYBEjA8ubYZOV2xTEkNWpyOZohUxRIATpBENJmgY4SWm0xoqBwfLjqvEgUcDXDMoEDtDgkT
 dp9cYeikHDB75C3qEz4FlCOnjT8jitaVBe9PCJnJOJZ5CK7dcL7UclKjwTtrpGCHZUqvGRXp+
 vW2AsqmJjCYewsOOHlF7mraBbQEgsz3zDwckkfm7WJpYotIjpRi/XtDYzD1M6qgIrKGgSo+c7
 yACKW+L/7XAgIamcpR7QVOPLDDq5nT6P/uvl3XeGcD8lwJx8bbuXu914s479fIzsOg/EArJUM
 PNj0NDd4AfVyevetHXQCQdaRJ+q57nrQY9Ks20TWtHqdQ5cbtvYBsleHOj/bmaxWKH46w3FNy
 Xu/tr0Px9pWb8IBnJbRUuUkucZOIwS3oKba0HOAzdPmZCsJczE7yQkQrdVHotoanaRMhb1Fwp
 7Y1At0BouoY5V9qu0JlT+wquAn5omSisxwMwBmobVlmlLMKJmFBHVHtxvb8YlVHsgNcbtsE+z
 RpxHVQvQ72GRgSh2y0PAH0MqWe/moIIOXjJ9FKiJTLe0WclwCqWDeeN2fR1G7i7nK61BO7ELs
 1sLu39xK7kDrTX/fpOCl+qCXDqNHC1QAbnrjUJ36k9e+yCtbB1wA9ZSJRca4DrdaWK/Sy+RQT
 mWulbDeR4pZPijGb2/JoB1zX5/cctRzLsoObhXmuEqgV0jm621OykmYmQKB4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> =E2=80=A6 This commit replaces return with the goto.

How do you think about to omit the wording =E2=80=9CThis commit=E2=80=9D f=
rom your change descriptions?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D97f9a3c4eee55b0178b518ae71=
14a6a53372913d#n151

Regards,
Markus
