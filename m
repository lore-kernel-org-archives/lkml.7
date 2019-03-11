Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0597C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB135206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="W6yGjo7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfCKMvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:51:39 -0400
Received: from mail-eopbgr760083.outbound.protection.outlook.com ([40.107.76.83]:55490
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbfCKMvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y276iZKLESu//Tg2eUkRRLZpa96/sWyuZG+wUwDVJ/c=;
 b=W6yGjo7ochG6fgb5fmwKGYxNZ8qzcN1WDjhe1JCqonY4LxV9ONxBV0oaVxKCMUjoH4b1X2L1HsihhdM6ng9X8BYCn06yPj488eTNTHFJWo/LtgxG7nWZV0rWfIdNyQu7k8H1RxBX35I5R4h6uF0FWWkreILsJ9pw1WWpydxKkTY=
Received: from SN6PR02CA0002.namprd02.prod.outlook.com (2603:10b6:805:a2::15)
 by BY2PR0201MB1861.namprd02.prod.outlook.com (2a01:111:e400:58b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.18; Mon, 11 Mar
 2019 12:51:32 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by SN6PR02CA0002.outlook.office365.com
 (2603:10b6:805:a2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.16 via Frontend
 Transport; Mon, 11 Mar 2019 12:51:32 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1686.19
 via Frontend Transport; Mon, 11 Mar 2019 12:51:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:32810 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h3KOx-0004bj-BT; Mon, 11 Mar 2019 05:51:31 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h3KOq-00048D-Ce; Mon, 11 Mar 2019 05:51:24 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1h3KOn-00047h-Mk; Mon, 11 Mar 2019 05:51:21 -0700
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
To:     Harini Katakam <harinik@xilinx.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
 <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
 <20190219172515.GC13075@lunn.ch>
 <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
 <adbb183836e22dfc4558beaa818677c24bacf3a8.camel@bootlin.com>
 <9cb2f7a8-a8cf-ef80-d260-cc67c072b5c5@xilinx.com>
 <8bb813fb-102b-00c9-fb6f-a3e928965051@xilinx.com>
 <CAFcVECJPtc3VQjK4WLCz1Wc4nopXnsLTKXFFY1ZpecgC+_PhyA@mail.gmail.com>
 <CAFcVECJ8G99XiqHpYYh=3Aj4Bt_2V4kfDdBmLQqpdo59BRjs-Q@mail.gmail.com>
 <CAFcVECKU7zD2ms76GH-mF2GxCtNr4RQ+2=jN_xppueQsUSq2wg@mail.gmail.com>
 <20190309161912.GD9000@lunn.ch>
 <CAFcVEC+bw6TMykW46z2MXOdx7yhWEO7SZ4AoYM27rBCzD1b15w@mail.gmail.com>
 <CAFcVECK8=6WMi4uDU-HBxzPxUwU=rRXM385wUup_fd9bHQvwwQ@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <12abec9f-29a8-7dfc-b7cc-59be34e1b6d7@xilinx.com>
Date:   Mon, 11 Mar 2019 13:51:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFcVECK8=6WMi4uDU-HBxzPxUwU=rRXM385wUup_fd9bHQvwwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(189003)(199004)(47776003)(486006)(9786002)(8936002)(64126003)(229853002)(31696002)(230700001)(305945005)(6246003)(2906002)(478600001)(36386004)(44832011)(81166006)(81156014)(65826007)(8676002)(5024004)(65806001)(126002)(26005)(54906003)(63266004)(77096007)(65956001)(4326008)(50466002)(426003)(476003)(31686004)(11346002)(2486003)(186003)(36756003)(58126008)(53546011)(110136005)(106002)(93886005)(106466001)(76176011)(336012)(6346003)(316002)(2616005)(446003)(356004)(6666004)(23676004)(5660300002)(41533002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1861;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f08abdc-aebf-4df5-f571-08d6a6204983
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BY2PR0201MB1861;
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1861:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1861;20:E8N6bZcQ9uEi2GJiXhRS56WVoPlBEyRAjcG/8uKGlxr+4uMR39icpc2p1C57xUO7mtvBUD42zEMn62wDJrW7+isOZmuT6NT38dgfrpfPS7u5TcBnAA9Si+39VyPgCRbZxwv2UUpstpc8x2p0/tjcHLljvpaU1gA0+va2ZJuFzgpY4nFXTFuVK7QTg2ehbPgIUVZlOS9Cb3Fj/80t/r7MVuO5Fh8uDreF16Djp6fh/hZnjNSVDi2+DcsQEzDviEjlM61lFbxO1QTrxSIcn4mrMUh6hvO8oYYY74OTPb5uGxyz+y1QjdrTxuQD0K1L3AQ+YSBMcFvVlDE2bo6F4HX50uzKdvKGK0B1/L8NESW9U580PSCZILh0Aq8SnOxtCffmmN06ZS4j7M1RW0ByFvHThrLvk9XpY9zxKU5aXjfXF5sIzcxkqIipZLJSiamRMzpZcfWy9rpKp83oBwwpfoj5vny0qOwGk5iA9ldhawifAB2RcY0unuozKFX27ySuRYY1
X-Microsoft-Antispam-PRVS: <BY2PR0201MB1861F605B00AF98856B38188C6480@BY2PR0201MB1861.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09730BD177
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyMDFNQjE4NjE7MjM6bWhpcG80eG05NmppZFFjTE5xZlZ3TWFu?=
 =?utf-8?B?a0VoVlR3UkVUcjhwbVhSQmxqNEhuWW5zaHk5cDhPRFFjYnU1cFA4VVhKQmJi?=
 =?utf-8?B?RjF2WEltaG1iZ2xRNU04ZXpmc1dHTG5FNS9oUVNWaUF2a0NpRlVBejBjVXhj?=
 =?utf-8?B?QVBac1BvRUJuZERVWWlTZG5jcVl2RjJnYmM0aFd5Lyt6aVZ1aGU5L0F5a05T?=
 =?utf-8?B?dlM2c29PeG1YNzVPQ1d5VFZWbjZoVzVZWlJZWnNBQ3lGQUFnT2NpeCszZW95?=
 =?utf-8?B?Tjl3KzZXMVRXQWlLOGVYT3FHWWZDZEFTQzRnYWF3bE5hT3plRGl2TGdkd2ZK?=
 =?utf-8?B?bXpva0lpUWs0ZFZhVS82cHNHRzhyWDZKZlVRdVlTOTZNcnhoVmRCamVlYlpt?=
 =?utf-8?B?cXkxVlVSdkpzYTJDL25xR1RVSHg2NmpSUWxDTEgxditWbFh4MkFUMlhwRHpH?=
 =?utf-8?B?dTFtYVpxMytCck5FZHVMT3JZd3JQUUE1c01iVkI5ZEVGVmlHYzZHU21ibE4r?=
 =?utf-8?B?WTVNUDN1T0FWdUtIMDlPc2dkT2xRcmdZMUJuNlU3eDRTZ1JyUE1vV1Fkbkcw?=
 =?utf-8?B?QWViUzVQV2JSOEJFSWVYMjQrQzJ1eHFOVlZpRExqOHorN1hsNForVVJQaGRD?=
 =?utf-8?B?MGNVVnl0RUhJS0JERGxuRUNoaEJHdkVYLzJlLzNId09mRWNLdUgyTTZYcEZa?=
 =?utf-8?B?NStYM1pCYUJiazJHRlZad1ZXNmduaEZhZUpTb2VxUHdqbXFUaFF2RzJyNmpy?=
 =?utf-8?B?NlkxTnQ3MGozVnR6NkJTZVJkbmZleW5ERjFpdHM3bmxCeFBCSzM2WTlNeXpm?=
 =?utf-8?B?L3ovNnNJaUhtZkg3cWdsTHA3MTZNSWxzangrdktrazlvWHBtd29HUFNRVzRt?=
 =?utf-8?B?cnFHeUtZQkhJS1FIT01uc29TNFRlNHRBZFlHM1Z5TUE5NnU3OW9VaVQ3SGlM?=
 =?utf-8?B?eUw4bzhxOER6OHZRUkwyaEFiY1NqWFVjNnlja0czVHBUUVdGdXA5UXJnV3Er?=
 =?utf-8?B?dWxiRDV2cUlDTzdjQzJuWDF6bmMvRDJseDQwMnMzV0JYREhZbE1rQ0VUWU52?=
 =?utf-8?B?VE9FMjd1WmYzOFZ1OG8xb3RSSjJhRzZwTnp3WWxMWGo4d3BTUGZNRkpDRmZj?=
 =?utf-8?B?aUpUczZCUVM1N1YrK3ZRVHU4T3VvRVpSNnAySWhPSjFUMHlFZHpkWlJpL2sv?=
 =?utf-8?B?WVJGMFgxY3NnK09BNjBWcjFjRUhtMUphbUdtU1lFbUp6cFpGV0VuVlZEbHVr?=
 =?utf-8?B?d3Z3RXdKNDV0eE4wRDNUSmpQVjducm5ISklaQUZyUEsrSys1WWhpNkxGSlNs?=
 =?utf-8?B?QzV5K3hYV2tKUEZFVk9xa1BsTWZIYUJFNnZsdnhkekdZVUVMdmhKL1Mvcnha?=
 =?utf-8?B?N3NWaWtBL1RwTEZ6OURPYllJQXBjc0xpdDFXaHZRdnFmRnR5Z2FtUlE4dnVH?=
 =?utf-8?B?VkxyclJOWWRSNkNtN3lTYlVaRW5xd2ZXQkptWmVJVUt1UEFQNVFwajhLQVBE?=
 =?utf-8?B?c3hmaEtsMU5jbWsrTCtjYlBEcHZSVmVkWEE2RWEwVkxpbFdtL1NpZEdFazdt?=
 =?utf-8?B?eTQ3c2R2UjJNNEl4cEZWcm1nQWgwaGtPYTl6VlpiRzFEek5XVzd3K1E1YzRr?=
 =?utf-8?B?aWZGYXN1YjhheXNDVHBNOE9OZThFS0M5OVhUeTFmVjM3Q1NYcWZwVFdsbmRl?=
 =?utf-8?B?RkZSR0tKUVYyYjNHNk1GUlB2UVZ1dFhTMHRlaWtmMGhpNmJzN1k3R2J3Zm5r?=
 =?utf-8?B?eUlVam1Udk90Z05mMDgvOXppbFFMMzFtQk9GdCt6dDI5ODFmdktsWlBXVFNy?=
 =?utf-8?B?bWNYVFhXN0RKdDBiZGExTXNMTjZpdlg0MllueE1GdkU5YVQxZz09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /APjZqHgwhPuKp+nq2Lv5mntF6miB8gQCf58ltjNMDeMjjURvWlVebM27HfOAWSV4Zzz3ZRnL7p0YBy7oRrFGOGj0A8oRs+FFDuIxcWA7aC/7q5fainn3/RxwC2kgEkEKTaUVJ7CV+JOV6P4sSpp3tiUlj+zCsZPDnp5Ku4/IR95TNczRheU8EbQB4gGiig0AhVmHD+lwAtusz2x/UwUQ2ik1j72nlqi8m3UJfPMbogK+WYhiHhiYsx+h6rB4+rxHo2pbiFXLOH8vOM8DzgvJtV1U1vLSBc3ItIw2r8GwyRGwFehOC3tERRUWZniw4wRnHbUOgHIxHGor8TR7TdzfD9n97qqbfR+x91qzem/Pm9EBhaVruDJdXqd9JJUzrB9btbnteQWudhkMPGnyRR9VO/qvv/EIcQcD8WKAXtmvqs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2019 12:51:31.8029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f08abdc-aebf-4df5-f571-08d6a6204983
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 03. 19 13:27, Harini Katakam wrote:
> Hi Andrew,
> On Mon, Mar 11, 2019 at 11:34 AM Harini Katakam <harinik@xilinx.com> wrote:
>>
>> Hi Andrew,
>> On Sat, Mar 9, 2019 at 9:53 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>>
>>>> Related to this, I have a query on how the DT node for gmii2rgmii should look.
>>>> One of the users of gmii2rgmii is Cadence macb driver. In Xilinx tree, we use
>>>> this piece of code to register this mdiobus:
>>>> + mdio_np = of_get_child_by_name(np, "mdio");
>>>> + if (mdio_np) {
>>>> + of_node_put(mdio_np);
>>>> + err = of_mdiobus_register(bp->mii_bus, mdio_np);
>>>> + if (err)
>>>> + goto err_out_unregister_bus;
>>>>
>>>> And the DT node looks like this:
>>>> ethernet {
>>>>     phy-mode = "gmii";
>>>>     phy-handle = <&extphy>;
>>>>
>>>>     mdio {
>>>>         extphy {
>>>>             reg = <x>;
>>>>         };
>>>>         gmii_to_rgmii{
>>>>             compatible = "xlnx,gmii-to-rgmii-1.0";
>>>>             phy-handle = <&extphy>;
>>>>             reg = <x>;
>>>>         };
>>>>     };
>>>> };
>>>
>>> Hi Harini
>>>
>>> You have this setup:
>>>
>>> MAC <==> GMII2RGMII <==> RGMII_PHY
>>>
>>> So you want the MAC phy-handle to point to the gmii_to_rgmii 'PHY'.
>>>
>>> Feel free to submit a patch extending
>>> Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt to include
>>> a MAC node, etc.
>>
>> Thank you, will do the same.
> 
> Thanks again for your input. So, I did some testing with this change.
> But the issue is that, if I point the phy-handle to gmi2rgmii,
> of_phy_connect will be called from the MAC and it will fail because gmii2rgmii
> is not a PHY driver and it does not have a standard PHY register set or ID.
> Which goes back to the discussion above whether this needs to changed in the IP.
> 
> But right now, it is a bridge device on the MDIO bus and has no PHY
> functionality.
> Moreover, any MAC is capable of accessing the external PHY with no interference
> in the MDIO path (the gmii2rgmii bridge just acts like another device
> on a common bus).
> 
> What Michal suggested below in uboot is that they register gmii2rgmii
> with a dummy
> PHY ID and then attach the external phy driver in its probe. I'm not
> sure if this will work
> in linux i.e. calling phy_connect_direct inside the gmii2rgmii probe.

In u-boot behavior and wiring is similar to fixed-link phy.

Thanks,
Michal

