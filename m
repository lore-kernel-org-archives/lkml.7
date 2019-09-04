Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DFEC3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA278233A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JcbkHeuI";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="l7Z1VyPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfIDErp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:47:45 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:25566 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725267AbfIDEro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:47:44 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x844hOos032090;
        Tue, 3 Sep 2019 21:47:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=proofpoint;
 bh=arm8fC2XgDn0yCzHCETe79kHwJggJArpFnT41eVwL2M=;
 b=JcbkHeuIa6FvAX2An8e5/wtLieqYPJ6tZWbX1mOMnF9MxzUy1M/W5yraEJgDT2pUIHCj
 W40Eoa8nLgnQFxGT+gkPi5bbR7ysYmTV4SF7sKbbs1yMPGWWp7hLEif8tjUjhZukjpo7
 ypAOz5KS1O+hLLqp76t7IfjRDRPEqq79EkEQIbHpuB2butAu2zlpzu2DF8Jy8/ll8euk
 wPFTX1Ahtx1BHtJ+P3SGtPmU7kBC5aW1y1rRUUhYYdFFJH4F0izUVHIMS7kXjZXDMM4k
 qZDiA/TOp9RfAQueQaCstey2RkcDqrznO+jquzBeeXVTCT+pm0Vukb2A/5+4R4L7kyaX ag== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pgaj@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2050.outbound.protection.outlook.com [104.47.46.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2uqmfvpdw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 21:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjXl9LEWmB8M5BP1sHrZGej+Fjfgb5JCD1mZ+RXpRrRPr15hgWnzStRA3YNT8A+/9K1skVELkRu531LNGvHTCvuQHAj1Wvu7LWzm72GfxUBXP/cmjNOAKKjQ0E+E6uQHZ1313hwfLOja5ZXn7mHS7IV4xONtlVHErkf/e6GPNbVf5mYoOW05YlW8jTWLEAYDp56IJt+OWkQY+PAI21P0Oi6AsGdAOpTYtKu005D6UMGTGgUqouJjxh7XJhhH08gkFlBDlArVmU86vbyOIvsbRC1ndZEVro2vIB9x0WXX4Ls/A522Ta+/sE09qL9IwNF7AonvCFWbVKkKUyv9I8LY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arm8fC2XgDn0yCzHCETe79kHwJggJArpFnT41eVwL2M=;
 b=j4FfmSqkgt/9VHHhjhR63BkDlPdWUi95VSTabrZyJlRZlkFmzUuKykmuAGb1pLw8EdHR+pmq3Sr0VgFMYllWvFewMHkcvaalJJ0SPfXEZDSnYA2NEzosvjR3eP2v6BB00uJmE0nBrlZZd5amfbCZiGOsIMyKpvsLUpvi6jckSGp+Sis/6lPtW1HzYsunRcZLhDdWgBg+LncczPQv5jakxPSuYy/eazH4KLbMObrCLIwr7nJr5/TYdSjPM2C9yftT0zotd1q02u1XEWDOiBNuzuYLso8UvV3Dk5HxL7956rugSGX/tBaWXEZQ73RMv4c2C10+kzkDH0b5AktFTPI3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 199.43.4.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arm8fC2XgDn0yCzHCETe79kHwJggJArpFnT41eVwL2M=;
 b=l7Z1VyPrBa/A2q/0yPeAe3OhW3uau5yf6IaOEQx/O1DW7xB2ZW7bQ9bZ0PrWM4rvyaANU5cRUa1k8YGK+mKOEe85/FVOFXgDaxFl3aGd3uHFz2ii+LlOTj/wOqIPpuXVqD7T1R2+nbeIqZJgv1tmhVdqkKnUSd+rV/32S38FxHA=
Received: from DM5PR07CA0117.namprd07.prod.outlook.com (2603:10b6:4:ae::46) by
 BL0PR07MB3873.namprd07.prod.outlook.com (2603:10b6:207:3f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Wed, 4 Sep 2019 04:47:28 +0000
Received: from BY2NAM05FT056.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by DM5PR07CA0117.outlook.office365.com
 (2603:10b6:4:ae::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2241.14 via Frontend
 Transport; Wed, 4 Sep 2019 04:47:28 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 BY2NAM05FT056.mail.protection.outlook.com (10.152.100.193) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2241.7 via Frontend Transport; Wed, 4 Sep 2019 04:47:27 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x844lNbd012718
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 4 Sep 2019 00:47:25 -0400
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Sep 2019 21:47:21 -0700
Date:   Wed, 4 Sep 2019 05:47:18 +0100
From:   Przemyslaw Gaj <pgaj@cadence.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: Re: [PATCH v2 1/5] i3c: master: detach and free device if
 pre_assign_dyn_addr() fails
Message-ID: <20190904044718.GB23588@global.cadence.com>
References: <cover.1567437955.git.vitor.soares@synopsys.com>
 <105a3ac1653e9ae658056a5ec9ddc2a084a61669.1567437955.git.vitor.soares@synopsys.com>
 <20190903111356.GA23588@global.cadence.com>
 <SN6PR12MB2655B0C2E9076EF7187A52F3AEB90@SN6PR12MB2655.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2655B0C2E9076EF7187A52F3AEB90@SN6PR12MB2655.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj7.global.cadence.com (158.140.32.114) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(51444003)(189003)(199004)(36092001)(107886003)(478600001)(2906002)(26826003)(5660300002)(6286002)(1076003)(54906003)(956004)(7696005)(426003)(11346002)(55016002)(2486003)(16526019)(386003)(26005)(76130400001)(33656002)(229853002)(66066001)(186003)(305945005)(50466002)(486006)(446003)(58126008)(476003)(316002)(7736002)(4326008)(53416004)(336012)(126002)(81156014)(81166006)(16586007)(8676002)(76176011)(6246003)(47776003)(3846002)(70586007)(70206006)(6666004)(356004)(53936002)(86362001)(23676004)(14444005)(6916009)(8936002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB3873;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91805095-632b-4c92-456a-08d730f2fced
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR07MB3873;
X-MS-TrafficTypeDiagnostic: BL0PR07MB3873:
X-Microsoft-Antispam-PRVS: <BL0PR07MB3873BE05FE18B5F876E45D77C2B80@BL0PR07MB3873.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0150F3F97D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 6QjLUUHKbRO8r9kkPowWscJA2Rj03EO1UbNoQ0bPRmNNy49uV45GvjijldW5DLo12eCC18j0F3+55l3+ICoVdMKAiyF6vQP7Veg3A9CmXUiJJHHqpc3cGdNzpv0c64yI2TkC4XIFwkYlus0UH8RsfDgx48Tu2sbZfZjRQEB0ZV8oZPGJsCew8tF9EG3fztUrWM72L6Aj1W4sWhYWo4r1sRZZlG+lWGdRTJc2eP9Ak9laQdESEzxjH4Qe+E1VOfm7BwcduQWEuqr5+uRz5pKRWYHKfOy8mhYhRGX11Coko9x8g+1FkrNffuOu+hbE6xXBbYCCSNyKBeWiQ5soVH8mGhHZYYzkQkYtzPn6Qe64GF1WKk//sfYY+18fCg1YF6mKuAoRXfHyW9NPSlnMYKCFW0JmepxFmqWq/mmP6Ardqq0=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2019 04:47:27.7299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91805095-632b-4c92-456a-08d730f2fced
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB3873
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_01:2019-09-03,2019-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=2 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909040049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 09/03/2019 11:57, Vitor Soares wrote:
> EXTERNAL MAIL
> 
> 
> From: Przemyslaw Gaj <pgaj@cadence.com>
> Date: Tue, Sep 03, 2019 at 12:13:57
> 
> > Hi Vitor,
> > 
> > I'm sorry for the delay.
> > 
> > The 09/03/2019 12:35, Vitor Soares wrote:
> > > EXTERNAL MAIL
> > > 
> > > 
> > > On pre_assing_dyn_addr() the devices that fail:
> > >   i3c_master_setdasa_locked()
> > >   i3c_master_reattach_i3c_dev()
> > >   i3c_master_retrieve_dev_info()
> > > 
> > > are kept in memory and master->bus.devs list. This makes the i3c devices
> > > without a dynamic address are sent on DEFSLVS CCC command. Fix this by
> > > detaching and freeing the devices that fail on pre_assign_dyn_addr().
> > 
> > What is the problem with sending devices without dynamic address in DEFSLVS?
> 
> How do you address them?
> For the DA field in DEFSLVS frame, the spec says: "shall contain the 
> current value of the Slave's assigned 7-bit Dynamic address". If the 
> device doesn't have the dynamic address assigned yet why send it?
>

What stops us from operating with this device in I2C mode using his SA?

> > Shouldn't we still inform rest of the devices about that? About fact that
> > device with SA without DA exists on the bus?
> 
> I would like to understand what is the use case for this? 

Look above. I2C mode still should be possible IMO. Just consider the case when
you really need some information from that device, main master can assign
dynamic address later but you can make some transfers. I know our framework
does not support that case but secondary master can be different system which
should know that this device exists and don't have DA yet, so I2C mode is
available.

> 
> On I3C spec table "I3C Devices Roles vs Responsibilities", Secondary 
> Master is not responsible to do Dynamic Address Assignment but it is 
> optional to do Hot-Join Dynamic Address Assignment.
> 

Yes, we discussed that few times during the review of Mastership patch series.

> > 
> > I think that this is limitation for us. Espacially we have SA and DA fields in
> > DEFSLVS frame so we are able to distinguish devices with and without Dynamic
> > Address.
> 
> I would say the reason behind is regarding how to distinguish i2c from 
> i3c devices.
> 
> > 
> > > 
> > > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > > ---
> > > Changes in v2:
> > >   - Move out detach/free the i3c_dev_desc from pre_assign_dyn_addr()
> > >   - Convert i3c_master_pre_assign_dyn_addr() to return an int
> > > 
> > >  drivers/i3c/master.c | 22 +++++++++++++++-------
> > >  1 file changed, 15 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > > index 5f4bd52..586e34f 100644
> > > --- a/drivers/i3c/master.c
> > > +++ b/drivers/i3c/master.c
> > > @@ -1426,19 +1426,19 @@ static void i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
> > >  		master->ops->detach_i2c_dev(dev);
> > >  }
> > >  
> > > -static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
> > > +static int i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
> > >  {
> > >  	struct i3c_master_controller *master = i3c_dev_get_master(dev);
> > >  	int ret;
> > >  
> > >  	if (!dev->boardinfo || !dev->boardinfo->init_dyn_addr ||
> > >  	    !dev->boardinfo->static_addr)
> > > -		return;
> > > +		return 0;
> > >  
> > >  	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
> > >  					dev->boardinfo->init_dyn_addr);
> > >  	if (ret)
> > > -		return;
> > > +		return ret;
> > >  
> > >  	dev->info.dyn_addr = dev->boardinfo->init_dyn_addr;
> > >  	ret = i3c_master_reattach_i3c_dev(dev, 0);
> > > @@ -1449,10 +1449,12 @@ static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
> > >  	if (ret)
> > >  		goto err_rstdaa;
> > >  
> > > -	return;
> > > +	return 0;
> > >  
> > >  err_rstdaa:
> > >  	i3c_master_rstdaa_locked(master, dev->boardinfo->init_dyn_addr);
> > > +
> > > +	return ret;
> > >  }
> > >  
> > >  static void
> > > @@ -1647,7 +1649,7 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
> > >  	enum i3c_addr_slot_status status;
> > >  	struct i2c_dev_boardinfo *i2cboardinfo;
> > >  	struct i3c_dev_boardinfo *i3cboardinfo;
> > > -	struct i3c_dev_desc *i3cdev;
> > > +	struct i3c_dev_desc *i3cdev, *i3ctmp;
> > >  	struct i2c_dev_desc *i2cdev;
> > >  	int ret;
> > >  
> > > @@ -1746,8 +1748,14 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
> > >  	 * Pre-assign dynamic address and retrieve device information if
> > >  	 * needed.
> > >  	 */
> > > -	i3c_bus_for_each_i3cdev(&master->bus, i3cdev)
> > > -		i3c_master_pre_assign_dyn_addr(i3cdev);
> > > +	list_for_each_entry_safe(i3cdev, i3ctmp, &master->bus.devs.i3c,
> > > +				 common.node) {
> > > +		ret = i3c_master_pre_assign_dyn_addr(i3cdev);
> > > +		if (ret) {
> > > +			i3c_master_detach_i3c_dev(i3cdev);
> > > +			i3c_master_free_i3c_dev(i3cdev);
> > > +		}
> > > +	}
> > >  
> > >  	ret = i3c_master_do_daa(master);
> > >  	if (ret)
> > > -- 
> > > 2.7.4
> > > 
> > 
> > -- 
> > -- 
> > Przemyslaw Gaj
> 
> Best regards,
> Vitor Soares

-- 
-- 
Przemyslaw Gaj
