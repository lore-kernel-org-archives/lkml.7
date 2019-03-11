Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB27C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9761D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xqWg8ZI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfCKGpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:45:47 -0400
Received: from mail-eopbgr820085.outbound.protection.outlook.com ([40.107.82.85]:40704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbfCKGpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih8maYr6rwyUCca4NI9LfxAR5Ijc0xxapglQ5CQk/Os=;
 b=xqWg8ZI4HK7TeELsFFfU2qM92/8ySmpRLzmzgYUgYtSkc4uyvv+XJj2LUBHU1j+bmCXS4YTQ2KD34VlS94gGayR0gtnHm2SpTaTmU918eYSbq0ndQtMYdqSwW6At6hXzOcWr42SqSYidcdj/ZgUbA1UISeXEnJBg6mtc9hSYvKE=
Received: from SN4PR0201CA0010.namprd02.prod.outlook.com
 (2603:10b6:803:2b::20) by MW2PR02MB3723.namprd02.prod.outlook.com
 (2603:10b6:907:2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.18; Mon, 11 Mar
 2019 06:45:41 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by SN4PR0201CA0010.outlook.office365.com
 (2603:10b6:803:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.18 via Frontend
 Transport; Mon, 11 Mar 2019 06:45:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lunn.ch; dkim=none (message not signed)
 header.d=none;lunn.ch; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1686.19
 via Frontend Transport; Mon, 11 Mar 2019 06:45:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50157 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h3Egu-0001h0-24; Sun, 10 Mar 2019 23:45:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h3Ego-0005yh-Uh; Sun, 10 Mar 2019 23:45:34 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2B6jQOo029467;
        Sun, 10 Mar 2019 23:45:26 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1h3Egf-0005xp-PW; Sun, 10 Mar 2019 23:45:25 -0700
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
To:     Andrew Lunn <andrew@lunn.ch>, Harini Katakam <harinik@xilinx.com>
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
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <29a9b36a-eeae-c768-cd71-c10294f011a1@xilinx.com>
Date:   Mon, 11 Mar 2019 07:45:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190309161912.GD9000@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(2980300002)(199004)(189003)(336012)(426003)(229853002)(50466002)(186003)(316002)(93886005)(23676004)(2486003)(77096007)(9786002)(26005)(76176011)(44832011)(5660300002)(81166006)(81156014)(64126003)(4326008)(36386004)(8936002)(31696002)(6246003)(6636002)(106002)(36756003)(8676002)(356004)(6666004)(486006)(65806001)(305945005)(106466001)(446003)(2906002)(476003)(126002)(11346002)(65956001)(2616005)(63266004)(58126008)(54906003)(230700001)(31686004)(47776003)(110136005)(65826007)(478600001)(41533002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR02MB3723;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 311c6fe6-7733-49fd-ac9f-08d6a5ed2d7f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:MW2PR02MB3723;
X-MS-TrafficTypeDiagnostic: MW2PR02MB3723:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;MW2PR02MB3723;20:yceVRCFLXcJ7PLt5+SNJDb/r+W56s4RT+M6zo7Khe5pLJVU/E8/aS+RnMDxENqDu8ZB9h0KT5eI356QZvormZph/l2CJSc1Jlt6OJiUCngBLmYWjgPe7mbfc0VusE5fvJjQBAMNg3elIglCmeyBPwLoHlTtOQVifr2RnsRaFVEXtuUHnWzFGHUnLdXFOgHC+/mr0W5mrX+5c95J1l9/420pRXuSPGX1cJds4rGhOVrT1WzECz6twdVDUX9XlO+oCEf75yQsTQc1DGa5uTu1PUewj7fRNpfckpTTphl2atg1tIbgDQzu9zf/gbX1ezgepYdzwgF21vVXxFrEY/0AQ46jgPhLGwhuBTt7hLP2e25IEHL2kHULk7TASsEu7a8ryZ+qUOK7lX5jR+rR4dz3kP1wYuEzbPMBHymGhEo+4p4+0Uwndp0Jscu5PG2dj5IFP3dsPd1kr9UUfib1YZbUGY5/z2y0pv4GI/JsBFid59iH6Ko+xB6MTKEPFROqS7ME8
X-Microsoft-Antispam-PRVS: <MW2PR02MB3723C1B91C17352973DD01D1C6480@MW2PR02MB3723.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09730BD177
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNVzJQUjAyTUIzNzIzOzIzOmxONkdBRFJpMHBBenhORWUybC9sT251Qm5O?=
 =?utf-8?B?YWRQT29xazZBT3MrNExobjRHSGN3WTNXeW1jNVJUVWZqZzJkVE1OREltWHRT?=
 =?utf-8?B?OXZ0K3ZEVXFpVytFSW55eCt0MkhwblR5cTB5Yk5zSUV0YWtKTk9raUQ3SHBo?=
 =?utf-8?B?SVJ1dVBrdHFkRWh3enZNQk9YOCtoS053L0wxdllPSTh3YmpCcmIrNWdpZzkz?=
 =?utf-8?B?bHc2MlJadjUwRWtmR2w5MHdsL0FhTDFBVHRlL1ZaK3JSTHQxTjlob0FiNStp?=
 =?utf-8?B?RDJJK1dJaFpuUlVIeVJHS1FFcGtuVkhGaVZNUU85bE9RVkprM0ZGSDZrR05r?=
 =?utf-8?B?b3dvbkp6aEg4ejl3dnVVOGNPSldVLzJSOURrZk5ZWTBZOHV5VHVidVZqQzFj?=
 =?utf-8?B?Q1NVS1JLQ3dEZEFPRU5xNU1PMnV3TlpNNW1oakFydzQwZ2hFTHd3VThLRExF?=
 =?utf-8?B?RXhSTmJqSTZkZkxGc2tPNlFRSytpSUhCU3FCWFlzRUllTVpvNGRXeXcvNmVQ?=
 =?utf-8?B?WUd4MThhTFBobFBaalduNEUveGNCa2ptY3Y3dWQ1bjFDNldPaVhWcU43Y2Ux?=
 =?utf-8?B?bGpmQWg2bGpZbmhoN2hyNnFZZ0puSkdHKytmUFFjSDRlSnc2QUg5SXlxR2Z1?=
 =?utf-8?B?RVloOU5NeG1ORzBCdFVKbEx2TlYyWjlxTkpXRnJPbkJtdCswRytqa3lndFRo?=
 =?utf-8?B?WWNBRUY5aFpBM3RrRU5RUEVvcm5zZ2k2SDYySlNPVW52ZHFXUlpZOENNSlRN?=
 =?utf-8?B?ZkJGT0pOQml0a054WU56M3FyNDdxM2N6S0FlMHlvQlVkQm1KOGwyUzF4Q05z?=
 =?utf-8?B?KzBRY1dFUW9zbWRtOUZWd0I4Wi93aGRZUnFKbHhYWVJ3dUhybmxIK21FaTdF?=
 =?utf-8?B?cmpuREhaSllzVFJaSkk3UG5hdHcyNjhpVElTR2FTdmpvVkNOUWp5cmZXd1px?=
 =?utf-8?B?V25sUnFCMkFtYXZCc2pnaEUrVk1HTk13cy8vZnBVYU40YkN0RVhGMW9aQk1J?=
 =?utf-8?B?VlloVmFnYVhtU3VERGRWS2RMbDgyS0UvcTNlUVpkNzIyZ0NGNks5K2c4WWt3?=
 =?utf-8?B?Wnd2U3c1SDJmU2E0U3ZQVEx5QTRSeU5TMzhhWVY0bXhITENDdFEvUlNXUmRG?=
 =?utf-8?B?S2xtTlJ0NFNrNldVYlQ4ZzU5aXgrbk9QZ3IzNFNDQko1dVpBN2t3THNiVkVv?=
 =?utf-8?B?cFVKL1VmRk9paFptRDJSR2txRjZhWk5iWVlLTzZsSUdTNjQ4RzBNbGk5U1k0?=
 =?utf-8?B?b0ZvckxOeEtSWUszZWRoN0JqcnhJY0pqcjhKOWw3L1krOUk1Rkoydy9jZTda?=
 =?utf-8?B?bVVwZDY2RW9KUlI3K0FyNmkzWG9zazVva25rYU1sTlBYQmpyTnJVcXUybkNo?=
 =?utf-8?B?NE14ZVRWd1lyQ2ljaDhpM2pLKytiV1RJZVlZU3Z6T1RvaTZsK1JGTHA1dWtx?=
 =?utf-8?B?VGw2Y1h2ajYxT2I5SFJtWG1JNkZaWm1Ub2N4cWo3anFDR2ZZVnBJSmFSV2lW?=
 =?utf-8?B?Y3NWVWZrTzIyWXFzKytZL0ltbTdTelBnTmtRdGFpRmRIWEgwWHJPeUtFME02?=
 =?utf-8?B?K09YaHNFTjgzYnN1dzRac2Fud3JQOUhDdjJoVTFWQjRuS3R4RnlneTRaaUtD?=
 =?utf-8?B?V1l6ZUFUZEZKbndnYXhTa2tXeUhpK1pQMFR5eUErdGkxZkRzSVJRQ255ZCt5?=
 =?utf-8?B?MXA0bnB2Z3hhVmFDdGg4ZUt1em94YjZKUHdpdExjbEp3M09mVU5DY3htQlZj?=
 =?utf-8?Q?Bp+W2AQJWO5a6WY2jCH6scSs14k7jrn7N1pAI=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Bznwhigu/Zmojwjx8bpvKcDtAPeqaP+mFDpnGDwkDmaZwqWmmrMm5fWwrtTDmH9Slleyw2HNTtuczyRF6anN5VLbtg6aDPqfNnqzVW4H7XXHzHz2dhLF6i3Z6FNZ5ipOZrJBL/X6mLE4fg2954wD6I6O3yoZgTWttiMMQPAdwM5glVcFR1BOMKAophgexdkx+/QSat3MwVA3i619sph7KBp5Yk34MOzBfajDvleJMXl1Xtn16XfsCP7hYrbe01XN6J3GembbQ1qenz3F06ICp+OcCQkcF28ip2V2VxxCa1I73VQxZ9It4djQF4aTCpwfgHEFj5+EZHfXrE2LS4VEC/octDWSkW2Do9zTHuQHIG0vEEHmvdNvl2YmZJQwGg+/XFp2+yAu6QExUMvu4H3q1UosxNwMbzJsEQjj/xHJcnQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2019 06:45:40.5075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311c6fe6-7733-49fd-ac9f-08d6a5ed2d7f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09. 03. 19 17:19, Andrew Lunn wrote:
>> Related to this, I have a query on how the DT node for gmii2rgmii should look.
>> One of the users of gmii2rgmii is Cadence macb driver. In Xilinx tree, we use
>> this piece of code to register this mdiobus:
>> + mdio_np = of_get_child_by_name(np, "mdio");
>> + if (mdio_np) {
>> + of_node_put(mdio_np);
>> + err = of_mdiobus_register(bp->mii_bus, mdio_np);
>> + if (err)
>> + goto err_out_unregister_bus;
>>
>> And the DT node looks like this:
>> ethernet {
>>     phy-mode = "gmii";
>>     phy-handle = <&extphy>;
>>
>>     mdio {
>>         extphy {
>>             reg = <x>;
>>         };
>>         gmii_to_rgmii{
>>             compatible = "xlnx,gmii-to-rgmii-1.0";
>>             phy-handle = <&extphy>;
>>             reg = <x>;
>>         };
>>     };
>> };
> 
> Hi Harini
> 
> You have this setup:
>   
> MAC <==> GMII2RGMII <==> RGMII_PHY
> 
> So you want the MAC phy-handle to point to the gmii_to_rgmii 'PHY'.

That means that MAC should talk to GMII2RGMII bridge as normall talks to
RGMII_PHY and then GMII2RGMII bridge should talk to RGMII_PHY.

Anyway good to read it because that's exactly how we have done it in u-boot.

Thanks,
Michal
