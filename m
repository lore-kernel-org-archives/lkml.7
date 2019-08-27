Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7659DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405A320656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="PzF/CKqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfH0Kx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:53:59 -0400
Received: from mail-eopbgr1400110.outbound.protection.outlook.com ([40.107.140.110]:24529
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfH0Kx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:53:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRiyIp+cacLYe0ZTQ40Nt8/T1wQnsIC9aLax9jeUfUTgmilsBblQoH6n+86IPDAKD5igJF7dy4VpvK+uxRhQ5QyoX+Vr8WAJdyCzA2BxuiSsFdKqbEAwkXAgW9gplzx7tT34r/xY4OheFu1Zqj5mFVM3I1Ut0Atp3ZAY78Z2es6vOAxJQWEBgDBhK9d5qYV4SjRU0EJk7BBw+HxJXLj37LhgB68GbHJVn1ufU7udr8uaPQcKBCy2MQ4h6mDJbZYM8r5EvqmPzzQ8xV85zf5wjTcFTBSv8fk6C1hk6x92EH5sTfKI3kub5LaO4NB2HJzlI4XZZ2vJIfDoItf0yI67gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UvsmTXgdYsMpf4uawkLnNmOwXOoF94FDXJkNd8pGDM=;
 b=fwzn7XBOkADVOCSfkGvxGqmu4Ca0oKaVLZ0y5tWKsL15RcWr8eyNfkqxW13KLlgQLnsjYIZn/m+zsmoZWj1RNg84ATUFZDaDnpVaTzzEYjDBrIWMdG7VtpiINGi0YUPxq8VcU/lakApPXJ05XVVLiRdEYYj+k2JG55XsXa2dRuRWC++DMjoE943JmRwSqedF10iYa4y8lPhqYxyFg6Ih/w4VOSwC97TVpdvfqK3qQ63hUCv3pNp8b3YsmgVbQFIxWPfaMHXaRFO+3xZjaZf178pOmNqum/j5luhUeqgfEg96ZsjqYoM+KYaGWvN4IPTKkfXWXtqRalINOz/dFSvNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UvsmTXgdYsMpf4uawkLnNmOwXOoF94FDXJkNd8pGDM=;
 b=PzF/CKqIstANMBa9ph7rEpgiDTXswXi/C38aZJDSbVl7BYWtz69F2oP2sDnwtjmvJR24IYhnv6QKl9BamQqerHAecTmd4iEzIAOVfg9jdiBiK6buZ9Dt5npix/O3srkAxvk72EryxHac/u54SxVeCwTzdZYxSsJRzfsCAtIs0Co=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.160.138) by
 TY1PR01MB1692.jpnprd01.prod.outlook.com (52.133.160.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Tue, 27 Aug 2019 10:53:54 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::acc8:abe:6eac:76e0]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::acc8:abe:6eac:76e0%7]) with mapi id 15.20.2178.023; Tue, 27 Aug 2019
 10:53:54 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v2] clk: Document of_parse_clkspec() some more
Thread-Topic: [PATCH v2] clk: Document of_parse_clkspec() some more
Thread-Index: AQHVXFQhjzSS11Xl9kyvJ1FqF5kDOqcOz06Q
Date:   Tue, 27 Aug 2019 10:53:54 +0000
Message-ID: <TY1PR01MB1769DCBAD9B79AA2AD36F241F5A00@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20190826212042.48642-1-sboyd@kernel.org>
In-Reply-To: <20190826212042.48642-1-sboyd@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61374bd9-7ea1-46b5-e65e-08d72adcdaca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TY1PR01MB1692;
x-ms-traffictypediagnostic: TY1PR01MB1692:
x-microsoft-antispam-prvs: <TY1PR01MB16925873D4E3ED3E0E38FACEF5A00@TY1PR01MB1692.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(6436002)(71190400001)(71200400001)(44832011)(81166006)(81156014)(6116002)(3846002)(486006)(8936002)(316002)(478600001)(54906003)(110136005)(5660300002)(7736002)(14454004)(74316002)(305945005)(66066001)(9686003)(55016002)(256004)(4326008)(25786009)(66946007)(66446008)(8676002)(64756008)(476003)(99286004)(76176011)(7696005)(2906002)(66476007)(66556008)(446003)(76116006)(11346002)(6246003)(6506007)(102836004)(229853002)(53936002)(33656002)(26005)(86362001)(52536014)(53546011)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1692;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C7yjRYhXbkF9RV7mpEqwE9vf6pRS8FYgykZY1jhJ7rJZL4shca4hYWJELr5ghFgYbuKUs3YQZp5ey1YcJjl3khhIeSOf4ATsjZZq9WbCG9XSGYR/PAnCU6ILOFphQAckCYuATVyHlbo658g9zrA+pbnIUi0rwfD1vk4gb0KwM5iNYZfSflMSt3yoHycso1ayqtWD2kyHlAaPxcJbCTt69aGvoH0ssDK6gIwGwqeZ77Mr2hNPkm48+5xakjfPXBKWElOuCuJn7K9WbCAEjaHJenBWSRX6uD5t3YjbDgZNkNNhZ7Fz5M3+Sxfn0dMpqi7cm+GRQ456JhxEbLKRxYxGXrAp7+2qrIYaQ5wfyjSlLg3FhJep2EGa4r4SwH81w/FlqQUo3xx/CupNhFxLRs7T1TGqD4pTKm/nabVdhHnkFZc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61374bd9-7ea1-46b5-e65e-08d72adcdaca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 10:53:54.6947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlm+9yTlIlN3AKLoe+2jmAWJtgX0Yettyn+VmaaTh3W7RWXdVH0+o/Hf8+s5MIyYiUtCxIgQ6Wl/yVqhQXW6UzAhwplhyZkRCbSQ2NSkMBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 26 August 2019 22:21 Stephen Boyd wrote:
> The return value of of_parse_clkspec() is peculiar. If the function is
> called with a NULL argument for 'name' it will return -ENOENT, but if
> it's called with a non-NULL argument for 'name' it will return -EINVAL.
> This peculiarity is documented by commit 5c56dfe63b6e ("clk: Add comment
> about __of_clk_get_by_name() error values").
>=20
> Let's further document this function so that it's clear what the return
> value is and how to use the arguments to parse clk specifiers.
>=20
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Thanks, this is much better than my comment!

Reviewed-by: Phil Edworthy <phil.edworthy@renesas.com>

> ---
>  drivers/clk/clk.c | 43 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c0990703ce54..5c6585eb35d4 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4316,12 +4316,43 @@ void devm_of_clk_del_provider(struct device
> *dev)
>  }
>  EXPORT_SYMBOL(devm_of_clk_del_provider);
>=20
> -/*
> - * Beware the return values when np is valid, but no clock provider is f=
ound.
> - * If name =3D=3D NULL, the function returns -ENOENT.
> - * If name !=3D NULL, the function returns -EINVAL. This is because
> - * of_parse_phandle_with_args() is called even if
> of_property_match_string()
> - * returns an error.
> +/**
> + * of_parse_clkspec() - Parse a DT clock specifier for a given device no=
de
> + * @np: device node to parse clock specifier from
> + * @index: index of phandle to parse clock out of. If index < 0, @name i=
s
> used
> + * @name: clock name to find and parse. If name is NULL, the index is us=
ed
> + * @out_args: Result of parsing the clock specifier
> + *
> + * Parses a device node's "clocks" and "clock-names" properties to find =
the
> + * phandle and cells for the index or name that is desired. The resultin=
g
> clock
> + * specifier is placed into @out_args, or an errno is returned when ther=
e's a
> + * parsing error. The @index argument is ignored if @name is non-NULL.
> + *
> + * Example:
> + *
> + * phandle1: clock-controller@1 {
> + *	#clock-cells =3D <2>;
> + * }
> + *
> + * phandle2: clock-controller@2 {
> + *	#clock-cells =3D <1>;
> + * }
> + *
> + * clock-consumer@3 {
> + *	clocks =3D <&phandle1 1 2 &phandle2 3>;
> + *	clock-names =3D "name1", "name2";
> + * }
> + *
> + * To get a device_node for `clock-controller@2' node you may call this
> + * function a few different ways:
> + *
> + *   of_parse_clkspec(clock-consumer@3, -1, "name2", &args);
> + *   of_parse_clkspec(clock-consumer@3, 1, NULL, &args);
> + *   of_parse_clkspec(clock-consumer@3, 1, "name2", &args);
> + *
> + * Return: 0 upon successfully parsing the clock specifier. Otherwise, -
> ENOENT
> + * if @name is NULL or -EINVAL if @name is non-NULL and it can't be foun=
d
> in
> + * the "clock-names" property of @np.
>   */
>  static int of_parse_clkspec(const struct device_node *np, int index,
>  			    const char *name, struct of_phandle_args
> *out_args)
> --
> Sent by a computer through tubes

