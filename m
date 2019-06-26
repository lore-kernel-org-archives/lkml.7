Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02818C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62A320663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3/c4QrXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfFZMQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:16:39 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2251 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfFZMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:16:39 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Codrin.Ciubotariu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="Codrin.Ciubotariu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Codrin.Ciubotariu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,419,1557212400"; 
   d="scan'208";a="39089860"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2019 05:16:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Jun 2019 05:17:48 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Jun 2019 05:17:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKJdxR4RNBZ/w1GwTev91D/A1GAl3Zh0jIGu607L+fY=;
 b=3/c4QrXAnWkg1I2o8nIyxFR9PbZPnCQjfo5d8wGTiQ54p6Dx+UxDzggZybktDhCcH4n1bEXBEP1B221TBKsxfHj6h/xe/6Q/3XyiIyT0eKacxu/CmYHUmmlZP3msRjUsfdnYjHeDgYJ1nvmJvuKYXnUm8lKNdk7QlGj+tX8APQg=
Received: from BN6PR11MB0051.namprd11.prod.outlook.com (10.161.153.153) by
 BN6PR11MB1602.namprd11.prod.outlook.com (10.172.22.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 12:16:36 +0000
Received: from BN6PR11MB0051.namprd11.prod.outlook.com
 ([fe80::b979:a7e7:97e:7098]) by BN6PR11MB0051.namprd11.prod.outlook.com
 ([fe80::b979:a7e7:97e:7098%2]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 12:16:36 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>
Subject: Re: [PATCH 2/2] ASoC: codecs: ad193x: Reset DAC Control 1 register at
 probe
Thread-Topic: [PATCH 2/2] ASoC: codecs: ad193x: Reset DAC Control 1 register
 at probe
Thread-Index: AQHVLA0AdrFhnpOmb06sug+VlL6ySaatyxCAgAAOyoA=
Date:   Wed, 26 Jun 2019 12:16:35 +0000
Message-ID: <60a36381-f2f3-18de-3f7c-4e51fc75445e@microchip.com>
References: <20190626104947.26547-1-codrin.ciubotariu@microchip.com>
 <20190626104947.26547-2-codrin.ciubotariu@microchip.com>
 <20190626112331.GB5316@sirena.org.uk>
In-Reply-To: <20190626112331.GB5316@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0035.eurprd07.prod.outlook.com
 (2603:10a6:800:90::21) To BN6PR11MB0051.namprd11.prod.outlook.com
 (2603:10b6:405:65::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45910852-91f0-421c-e1a3-08d6fa30220a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1602;
x-ms-traffictypediagnostic: BN6PR11MB1602:
x-microsoft-antispam-prvs: <BN6PR11MB160219AF8C1F36FE31E062C5E7E20@BN6PR11MB1602.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(14454004)(6486002)(8936002)(26005)(99286004)(76176011)(36756003)(72206003)(53936002)(4744005)(316002)(102836004)(186003)(256004)(6436002)(3846002)(8676002)(2906002)(6116002)(478600001)(52116002)(68736007)(81166006)(81156014)(305945005)(486006)(6916009)(4326008)(86362001)(54906003)(7736002)(31696002)(66066001)(31686004)(229853002)(6246003)(25786009)(71190400001)(66556008)(71200400001)(6512007)(6506007)(386003)(53546011)(66946007)(73956011)(66476007)(11346002)(476003)(446003)(2616005)(66446008)(5660300002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1602;H:BN6PR11MB0051.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gls5iOkaOOg4oHV6RDmtB+lmhrHxIJD3XZ7okAssKazrqPnrlFLdsen5FL5YnKfzsAlAf6biPRgoU4M6+TTUBOuTYXes9y6jEV1jxQ3cct2beSXPE2R8F9g7CUFCJThMxUuYMWdIMz6pgLb51HDUaTSjYuZE7h7ELUlyp9EWs5DrnJQuvvnqknbZGeV4FLPjkxmaNhNhQ/ByMTkQiBN72AgDVlp0Tx74+S9vm4M4mfwrTbAvdUTK1QcMM7aRWRyWx76FTpdxSP/2gLyXKAy+RrVB37eecWEtuhOWLFXOoi2PrQDyzR6BElo8vzSRNqlZKOSAAjJfILf2c2NKxxwylyeATqPpewmpTQ7UJdEIg5AK4OoLjUdvJD3hFEH+66KsrLRZAlD0iGhC3MoukCRoJc2SnH7onrQ1heeuEqJ9NwE=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <56F9F74196D8B244A690BADBF5F0899C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 45910852-91f0-421c-e1a3-08d6fa30220a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 12:16:36.0074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Codrin.Ciubotariu@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.06.2019 14:23, Mark Brown wrote:
> On Wed, Jun 26, 2019 at 01:49:47PM +0300, Codrin Ciubotariu wrote:
>> Since the ad193x codecs have no software reset, we have to reinitialize =
the
>> registers after a hardware reset. For example, if we change the
>> device-tree between these resets, changing the audio format of the DAI l=
ink
>> from DSP_A with 8 TDM channels to I2S 2 channels, DAC Control 1 register
>> will remain configured for 8 channels. This patch resets this register a=
t
>> probe to its default value.
>=20
> Would it not be more robust/complete to have a set of register defaults
> and write the whole lot out rather than individually going through and
> adding writes for specific registers as needed?
>=20

It would indeed. I will make two patches, one that implements what you=20
suggested, for the registers that we touch only, and another one that=20
will add AD193X_DAC_CTRL1 to these defaults. You can drop this patch.

Thanks and best regards,
Codrin
