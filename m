Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EED1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0360020880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xtHah/oP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDHGUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:20:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47194 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbfDHGUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:20:52 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x386GODF028915;
        Mon, 8 Apr 2019 08:20:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=6LX5mzE+1WMNyi9ARs4pczW4dIsFnwefrN6GHpeAjZI=;
 b=xtHah/oPdqW2cCR6rCC+abTav6eDznvo9t1fzkpUSkXpu9mw5eqnLJgKdnMxA5KbtJru
 +9kZaejIhu//I0PehrfcSU+BDFzJY0hXwhWHPQDwfMSKy7ISl67ZTpFtx2KkOCryG9QS
 DiXw9ZpiHFL6AFLayEJrbFRxXH97pdtOfkd9oTLMdtR1I0cIFVB+fQc0246CAHKSvl+b
 tZGwnDpRzclzY87mNxhFlDmMD6h3CsP9pRa7GlcMgbtHl92GEZ8+ZtynXF/4/pMUm6Kg
 pvDMcfcCwdFXj+Q/uhS6G7aQPTv5n5TeU1qLsZt65+/GPCtG2FFZIzz7eoIxVfRDEl3k 3g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rpr7w96nv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 08 Apr 2019 08:20:37 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B66B3A;
        Mon,  8 Apr 2019 06:20:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B9C131135;
        Mon,  8 Apr 2019 06:20:35 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 8 Apr
 2019 08:20:35 +0200
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Mon, 8 Apr 2019 08:20:35 +0200
From:   Mickael GUENE <mickael.guene@st.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Hugues FRUCHET" <hugues.fruchet@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: Document MIPID02 bindings
Thread-Topic: [PATCH v4 1/2] dt-bindings: Document MIPID02 bindings
Thread-Index: AQHU5INMzFmwzAKEgEq2QsQljXgLI6Yu3lWAgAAA2ACAAtyeAA==
Date:   Mon, 8 Apr 2019 06:20:35 +0000
Message-ID: <9361076f-9007-fba8-302d-c32cdb8f5c87@st.com>
References: <1552373045-134493-1-git-send-email-mickael.guene@st.com>
 <1553680545-73278-1-git-send-email-mickael.guene@st.com>
 <1553680545-73278-2-git-send-email-mickael.guene@st.com>
 <20190406103525.amfsljsz4twi3xq2@valkosipuli.retiisi.org.uk>
 <20190406103826.cniksvg7xuog3gti@valkosipuli.retiisi.org.uk>
In-Reply-To: <20190406103826.cniksvg7xuog3gti@valkosipuli.retiisi.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <89241381E136EC43A4987D746E920DB5@st.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 4/6/19 12:38, Sakari Ailus wrote:
> On Sat, Apr 06, 2019 at 01:35:25PM +0300, Sakari Ailus wrote:
>> Hi Mickael,
>>
>> On Wed, Mar 27, 2019 at 10:55:43AM +0100, Mickael Guene wrote:
>>> This adds documentation of device tree for MIPID02 CSI-2 to PARALLEL
>>> bridge.
>>>
>>> Signed-off-by: Mickael Guene <mickael.guene@st.com>
>>> ---
>>>
>>> Changes in v4:
>>> - Fix and clarify endpoints properties documentation
>>>
>>> Changes in v3: None
>>> Changes in v2:
>>> - Add precision about first CSI-2 port data rate
>>> - Document endpoints supported properties
>>> - Rename 'mipid02@14' into generic 'csi2rx@14' in example
>>>
>>>  .../bindings/media/i2c/st,st-mipid02.txt           | 82 ++++++++++++++=
++++++++
>>>  MAINTAINERS                                        |  7 ++
>>>  2 files changed, 89 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-m=
ipid02.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.=
txt b/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
>>> new file mode 100644
>>> index 0000000..754a175
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
>>> @@ -0,0 +1,82 @@
>>> +STMicroelectronics MIPID02 CSI-2 to PARALLEL bridge
>>> +
>>> +MIPID02 has two CSI-2 input ports, only one of those ports can be acti=
ve at a
>>> +time. Active port input stream will be de-serialized and its content o=
utputted
>>> +through PARALLEL output port.
>>> +CSI-2 first input port is a dual lane 800Mbps per lane whereas CSI-2 s=
econd
>>> +input port is a single lane 800Mbps. Both ports support clock and data=
 lane
>>> +polarity swap. First port also supports data lane swap.
>>> +PARALLEL output port has a maximum width of 12 bits.
>>> +Supported formats are RAW6, RAW7, RAW8, RAW10, RAW12, RGB565, RGB888, =
RGB444,
>>> +YUV420 8-bit, YUV422 8-bit and YUV420 10-bit.
>>> +
>>> +Required Properties:
>>> +- compatible: should be "st,st-mipid02"
>>
>> s/should/shall/ overall; other values aren't really valid in any of the
>> cases.
>=20
> As this is the only change and it's trivial, I can do that as well. Let m=
e
> know if that works for you.
>=20
 I prefer to keep it with my patch serie if you are ok ?

Mickael=
