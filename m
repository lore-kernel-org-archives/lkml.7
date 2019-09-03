Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4FFC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18C022D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FQxCgxEE";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="D59QTRyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfICLOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:14:36 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:5774 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728571AbfICLOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:14:35 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83BEBKk028202;
        Tue, 3 Sep 2019 04:14:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=proofpoint;
 bh=bEg2zUh/RgQnqAV9TqCU0ybxLZsFIRFUMU7IvVPokmQ=;
 b=FQxCgxEE/WIxQCI2hAr68YFhM7axjYE1y3YhChsF5cr+9JywZUiP8lgjl7yg5zIxnAub
 je+J7EOcTxSTsaf0esuS5tHfrClS8EoDbG2Ls5+HZd5gsx5TlcTbJEnpnQ0SoA6AwBrt
 MVZwSR4YQCyjYG7QHI4+Zm/2gLlCCM+orxGyXRX0XheG9qNAkf1Cplx9RQ/598WSSSnm
 KSTuw9dW5SJ7Y6s+yNpt4DkBQlYCIy/U/scn8TpPDRJ/aFx2KxAuA7SKRDZZJa0ujfw2
 G1kUE3nZ/mT2fBRP1oAG/XuYZiYREnH2saDPJHSiUths2onNZDSe1Ct4EfB1cx4HVA65 JQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pgaj@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2054.outbound.protection.outlook.com [104.47.48.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2uqmfvk01q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 04:14:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0NebxnMosxHqnoKa67f3udffvPrqCEQjf+ulaeZaPYYGCbh1D5mpLh0VBX/1DP6vWubU7iRsbZltN8uatJs6rbVIWTIAEQAJtDXQ6uYK0ofJyOd9pqGR9DJk5QeLreEQdtJSA5W+42J8H0VYcHDHp58ttCkl5mf+3DHup2+QhMy4aho9/kpcieE2kUTyoifoF/qC9hXObVNCoyEdLkgGPc+atVuGmKKi3WpnqP2/pjnHfFqbreD6dkzzH16i6pQXLQTQ9d0ORdEpUFMG5Y+LCJzWJ4pHx1GEpyr6tc0VuWrevwCidKrCGpXP+3k+paXvcOd27tDLJDyOqga8K/sVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEg2zUh/RgQnqAV9TqCU0ybxLZsFIRFUMU7IvVPokmQ=;
 b=ZxKmBOIpIi696+gyan7VFdZTybyhlvqBpMnggjrOgdojRJSUAOPG3e0JqGcHqSCakVklqbn2DJkbHIJLReus++8YwgIvWF2dSKC9dYcbZLwOgt7MoGmR3iR+Uo351TooqCUQUdFGLN4ab1KBMEN9CeeCElJX2OgDc2/mz9X53uy3id6zNIsVrPiWfFsJlUMK5t+jiWFmTYAtMcpMbyV0XwBKeMc8adEUQbMjAypX6hT0D2JDJ/ob9iZZ/q8i18emd9VRlMjDSRG+2K3eXmVUj4gB8Cp/vrqjf32H2ZlON9o+21+BmD2bnVWMrE4yy7XzyYTJfwvvhOt0sc8BeaDQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 199.43.4.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEg2zUh/RgQnqAV9TqCU0ybxLZsFIRFUMU7IvVPokmQ=;
 b=D59QTRyO5JULB6L3va/JTzvP72muILGQQoOUbp2ANqqNnTTd9uj3gf+3Ft+rjXfFKNjmwojrCxHqEZae+hwTaRVEznDF4brlfz6k9+DfexafB5P3lZKkongtwPEu1QzkskO4NmT8kwe2xa2gE6qv4HE1dL0xFCVIcqCiINdOau8=
Received: from BYAPR07CA0031.namprd07.prod.outlook.com (2603:10b6:a02:bc::44)
 by SN6PR07MB4749.namprd07.prod.outlook.com (2603:10b6:805:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.20; Tue, 3 Sep
 2019 11:14:07 +0000
Received: from CO1NAM05FT040.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::200) by BYAPR07CA0031.outlook.office365.com
 (2603:10b6:a02:bc::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.20 via Frontend
 Transport; Tue, 3 Sep 2019 11:14:07 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT040.mail.protection.outlook.com (10.152.96.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.7 via Frontend Transport; Tue, 3 Sep 2019 11:14:07 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x83BE2fW015911
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 3 Sep 2019 07:14:04 -0400
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Sep 2019 04:14:00 -0700
Date:   Tue, 3 Sep 2019 12:13:57 +0100
From:   Przemyslaw Gaj <pgaj@cadence.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-i3c@lists.infradead.org>, <bbrezillon@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH v2 1/5] i3c: master: detach and free device if
 pre_assign_dyn_addr() fails
Message-ID: <20190903111356.GA23588@global.cadence.com>
References: <cover.1567437955.git.vitor.soares@synopsys.com>
 <105a3ac1653e9ae658056a5ec9ddc2a084a61669.1567437955.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <105a3ac1653e9ae658056a5ec9ddc2a084a61669.1567437955.git.vitor.soares@synopsys.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj7.global.cadence.com (158.140.32.114) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(2980300002)(51444003)(189003)(199004)(36092001)(486006)(2486003)(54906003)(126002)(26826003)(6916009)(58126008)(316002)(23676004)(33656002)(86362001)(6286002)(478600001)(55016002)(386003)(16526019)(7736002)(4326008)(53936002)(53416004)(2906002)(229853002)(305945005)(6246003)(50466002)(3846002)(6116002)(70586007)(70206006)(1076003)(5660300002)(8676002)(8936002)(47776003)(66066001)(446003)(476003)(7696005)(336012)(81156014)(76176011)(6666004)(356004)(11346002)(956004)(76130400001)(26005)(16586007)(186003)(81166006)(426003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4749;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 087ed0be-542f-4d85-8e19-08d7305fd698
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR07MB4749;
X-MS-TrafficTypeDiagnostic: SN6PR07MB4749:
X-Microsoft-Antispam-PRVS: <SN6PR07MB4749F3AE734507EA7D9AAED9C2B90@SN6PR07MB4749.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01494FA7F7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: T8yxjcN7rgBi7syXJKbsM3aprl9CipH2tQL+/ltKzyoZvWADAvOjW0slBNyNFWMlTNVYaCM84DCkZKeNPAV81EfS5Zx47s+x/EGsmfmc5WBWK9VJzuW2B/jlygfmtOJ1OYrOtFI86Kzt/6K9cPK5wfmRC3BqgUILKZ7/8aTK4SzJxDTKO9GXcwcagrTRMLmP3BSlASnyPflo+aMOFoByZiL24ym0SXXkMSFVQ3yx4rc/712ONYdCRWDQgTsDiaE3/JV34Dc4/H0B4XxQg45YO78BKLOY1PKlRGWUOhEKs/xn9WqQGRf80eFS/ZY0Odvtsp2DWlo6JNPF8/mpHTAHhoc2kYMZo2UnZw89ilv9KpCRZ/bkz305AbjPmtoVS11RI2hwai00bcllGqV/WQETQnW5MTLFVUIlTStmR1Yn7Mw=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2019 11:14:07.2960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087ed0be-542f-4d85-8e19-08d7305fd698
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4749
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_01:2019-09-03,2019-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=2 malwarescore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909030118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitor,

I'm sorry for the delay.

The 09/03/2019 12:35, Vitor Soares wrote:
> EXTERNAL MAIL
> 
> 
> On pre_assing_dyn_addr() the devices that fail:
>   i3c_master_setdasa_locked()
>   i3c_master_reattach_i3c_dev()
>   i3c_master_retrieve_dev_info()
> 
> are kept in memory and master->bus.devs list. This makes the i3c devices
> without a dynamic address are sent on DEFSLVS CCC command. Fix this by
> detaching and freeing the devices that fail on pre_assign_dyn_addr().

What is the problem with sending devices without dynamic address in DEFSLVS?
Shouldn't we still inform rest of the devices about that? About fact that
device with SA without DA exists on the bus?

I think that this is limitation for us. Espacially we have SA and DA fields in
DEFSLVS frame so we are able to distinguish devices with and without Dynamic
Address.

> 
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
> Changes in v2:
>   - Move out detach/free the i3c_dev_desc from pre_assign_dyn_addr()
>   - Convert i3c_master_pre_assign_dyn_addr() to return an int
> 
>  drivers/i3c/master.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 5f4bd52..586e34f 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1426,19 +1426,19 @@ static void i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
>  		master->ops->detach_i2c_dev(dev);
>  }
>  
> -static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
> +static int i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
>  {
>  	struct i3c_master_controller *master = i3c_dev_get_master(dev);
>  	int ret;
>  
>  	if (!dev->boardinfo || !dev->boardinfo->init_dyn_addr ||
>  	    !dev->boardinfo->static_addr)
> -		return;
> +		return 0;
>  
>  	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
>  					dev->boardinfo->init_dyn_addr);
>  	if (ret)
> -		return;
> +		return ret;
>  
>  	dev->info.dyn_addr = dev->boardinfo->init_dyn_addr;
>  	ret = i3c_master_reattach_i3c_dev(dev, 0);
> @@ -1449,10 +1449,12 @@ static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
>  	if (ret)
>  		goto err_rstdaa;
>  
> -	return;
> +	return 0;
>  
>  err_rstdaa:
>  	i3c_master_rstdaa_locked(master, dev->boardinfo->init_dyn_addr);
> +
> +	return ret;
>  }
>  
>  static void
> @@ -1647,7 +1649,7 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  	enum i3c_addr_slot_status status;
>  	struct i2c_dev_boardinfo *i2cboardinfo;
>  	struct i3c_dev_boardinfo *i3cboardinfo;
> -	struct i3c_dev_desc *i3cdev;
> +	struct i3c_dev_desc *i3cdev, *i3ctmp;
>  	struct i2c_dev_desc *i2cdev;
>  	int ret;
>  
> @@ -1746,8 +1748,14 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  	 * Pre-assign dynamic address and retrieve device information if
>  	 * needed.
>  	 */
> -	i3c_bus_for_each_i3cdev(&master->bus, i3cdev)
> -		i3c_master_pre_assign_dyn_addr(i3cdev);
> +	list_for_each_entry_safe(i3cdev, i3ctmp, &master->bus.devs.i3c,
> +				 common.node) {
> +		ret = i3c_master_pre_assign_dyn_addr(i3cdev);
> +		if (ret) {
> +			i3c_master_detach_i3c_dev(i3cdev);
> +			i3c_master_free_i3c_dev(i3cdev);
> +		}
> +	}
>  
>  	ret = i3c_master_do_daa(master);
>  	if (ret)
> -- 
> 2.7.4
> 

-- 
-- 
Przemyslaw Gaj
