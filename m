Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77414C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0956220693
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HRoTBOMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDLAha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:37:30 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:51814 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDLAha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 20:37:30 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190412003727epoutp02d0ba3d7e5ce955fd67c2af1424a7d70d~UkwsRj3hC2199221992epoutp02X
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 00:37:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190412003727epoutp02d0ba3d7e5ce955fd67c2af1424a7d70d~UkwsRj3hC2199221992epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555029447;
        bh=EG5UUt1fhOOyO2dRubmqvo/jwSJJUu9GXL0ZwoRXhP8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HRoTBOMnQnT2n26u3MSVzQ5yq9E18Ox5b5LWIHfx4QAAXBSA/iIcv4Q/71Cwyy3ah
         PWZswI7hf00MaQdOH1NdVYc5V2TzwYYrlCUjfWGexyQ9pjmFr7Hf5IOkA/KAgHN5Bq
         oX5l9nTHXYmk1uAa2N1kS02wka7h5IblUG/GGEFs=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190412003724epcas1p458f5ab5942469a27ee81cd27c224ccec~Ukwpl5MfY1085410854epcas1p4U;
        Fri, 12 Apr 2019 00:37:24 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.E5.04108.4CDDFAC5; Fri, 12 Apr 2019 09:37:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190412003723epcas1p4841ac39da7b1dcdd379101294fcd8407~Ukwo7Kqhj1085410854epcas1p4T;
        Fri, 12 Apr 2019 00:37:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190412003723epsmtrp22e9a84858a3f7af368efc69f63bdc8a1~Ukwo6T7SL0232002320epsmtrp2h;
        Fri, 12 Apr 2019 00:37:23 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-39-5cafddc49cf4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.68.03692.3CDDFAC5; Fri, 12 Apr 2019 09:37:23 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190412003723epsmtip1538b52e9fbd2e30dbbab1fcb3cb58274~UkwoyP9tf1377413774epsmtip1e;
        Fri, 12 Apr 2019 00:37:23 +0000 (GMT)
Subject: Re: [PATCH] extcon: arizona: Disable mic detect if running when
 driver is removed
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        myungjoo.ham@samsung.com
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <22018fcb-ac96-8cc4-c432-770962b37ef4@samsung.com>
Date:   Fri, 12 Apr 2019 09:38:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404163356.17773-1-ckeepax@opensource.cirrus.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3e3U1rdZuaJ3vZjSINH1ebTksLFBkoNCgoyrLLvOhwj9vu
        7C1Z4iPN3iTZqMyMpdnKVsjCBFszg8wwIbThchIWMSkrKqLadpX873PO75zz/X1/vyPF5PVE
        lFRrMLMmA6OjiFD84ZOYuDin25af2HljjvJ1ZQdSDjoshHLkmJVQTk12izfhqgbLX6Q6ZW9F
        qqmOZWpsR8mGYpYpZE3RrEFjLNQaijKo3C0FWQWKlEQ6jk5TplLRBkbPZlDZeeq4HK3Or0ZF
        72N0pf6UmuF5KiFzg8lYamaji428OYNiuUIdl8bF84yeLzUUxWuM+nQ6MTFJ4S/cU1JcX2uR
        cLZ5B5znHuHlyDunFoVIgVwHI333RLUoVConOxH0jkzgQvAFgfv+C7EQfEfQUH9HPNPiO20l
        hIMuBC6vDROCSQRfr48Fq8LIfBisKQ9yOJkHTZX9QcbIjdBU8SrIBBkL3RNviADPJ1fA0A8v
        CrCMzIQ2xygWYJxcBfahNkmAI8jtMOq6KxZqFkDfpXE8wCFkFljfn8CF+ZEwPH5VJPByqHhw
        OXg5IJ8R8LW1EhMsZEP7zY/TdsLgY69dInAUTPm6CIEPw60+JyE01yCwdw9MNyRDd8t5v4LU
        rxADNkeCIDYPfN9OigNpIGVQUyUXqlfCoMctEngRNFefmB6vggbLS9EZtKJxlp3GWRYaZ1lo
        /C92DeGtaCHL8foilqc5xezv7kDBVYxN60Su/rweREoRNVemTrfly8XMPv6gvgeBFKPCZVtx
        f0pWyBw8xJqMBaZSHcv3IIX/tc9iUREao3+xDeYCWpGUnJysXEenKGiaipTZNmXly8kixsyW
        sCzHmmb6RNKQqHJ0PWbN4rpdrue/WvWbbz8u63zKHF4fb7E77+/1yCa11Z+3tKWCdWB4aZnY
        4xNrxt6qrMaq47uHdf2r21PL23vufZCcHhngajjNbzznSvO7XK8vZbfD05z9U7JTe4Ffa7fO
        X/LH61G76ve7w7bVOX+1XHSznzLi+Ykjjhb90dwmCueLGToWM/HMP8CTU1qgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnO7hu+tjDE7Nl7a40rqJ0eLyrjls
        FrcbV7BZfH6/n9WBxWP6nP+MHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJXR2zWHvWA9X8WR
        SbtZGhgfc3cxcnJICJhIvOtfwdbFyMUhJLCbUWLvugvMEAlJiWkXjwLZHEC2sMThw8UQNW8Z
        Ja69ms0OUiMsECNxuaOBFcQWEfCRWNh6DsxmFrCXWNh8kRWiYRqjxMZ7C5lAEmwCWhL7X9xg
        A7H5BRQlrv54zAhi8wrYSazedR9sMYuAqsSWq6vBFogKREiceb+CBaJGUOLkzCdgNqeAs8SK
        Z50sEMvUJf7Mu8QMYYtL3HoynwnClpdo3jqbeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW5
        6bnFhgWGeanlesWJucWleel6yfm5mxjB0aGluYPx8pL4Q4wCHIxKPLwrbNbHCLEmlhVX5h5i
        lOBgVhLhDWEBCvGmJFZWpRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp
        1cDo9emRgcg9mfe1/Kt/72s06BJjKPruOOf+yY9zJR/8v6r3zDBpktRmqfV/NM1aRZfMe/04
        MkH08hauJduEBdfZLvz5jC1+/rXFV7N53mna/513SerjBK3rHY/rlr6Lbky1khETkbmiso83
        g92lUbydeX984eLpZq4nRHvfXeQrPPGj017rz5wIJZbijERDLeai4kQA3cplsYoCAAA=
X-CMS-MailID: 20190412003723epcas1p4841ac39da7b1dcdd379101294fcd8407
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190404163407epcas1p2a59f81b2486e552d35b8a900dffa53b5
References: <CGME20190404163407epcas1p2a59f81b2486e552d35b8a900dffa53b5@epcas1p2.samsung.com>
        <20190404163356.17773-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 19. 4. 5. 오전 1:33, Charles Keepax wrote:
> Microphone detection provides the button detection features on the
> Arizona CODECs as such it will be running if the jack is currently
> inserted. If the driver is unbound whilst the jack is still inserted
> this will cause warnings from the regulator framework as the MICVDD
> regulator is put but was never disabled.
> 
> Correct this by disabling microphone detection on driver removal and if
> the microphone detection was running disable the regulator and put the
> runtime reference that was currently held.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/extcon/extcon-arizona.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index da0e9bc4262fa..9327479c719c2 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -1726,6 +1726,16 @@ static int arizona_extcon_remove(struct platform_device *pdev)
>  	struct arizona_extcon_info *info = platform_get_drvdata(pdev);
>  	struct arizona *arizona = info->arizona;
>  	int jack_irq_rise, jack_irq_fall;
> +	bool change;
> +
> +	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
> +				 ARIZONA_MICD_ENA, 0,
> +				 &change);
> +
> +	if (change) {
> +		regulator_disable(info->micvdd);
> +		pm_runtime_put(info->dev);
> +	}>  
>  	gpiod_put(info->micd_pol_gpio);
>  
> 

Applied it.


IMO, I think that this driver have to handle the exception handling
when regmap_update_bits_check() returns error or 'change' value
is not changed. This driver have same issue about exception handling
on multiple places. Please take it on separate patche.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
