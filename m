Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B7CC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857B52377B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bx8iD3gE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbfHVIRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:17:17 -0400
Received: from mail-eopbgr820054.outbound.protection.outlook.com ([40.107.82.54]:2204
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfHVIRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:17:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU1fxeXKRcukIjdfG8V7SIYAKkSyjJt0RzPNAoj6LVgrF/jD8brptXWfmTHq7vnekx0DxWaPNVSVCDJxsHhqcqdZpFf/kKI15BLH8k1bIiwAChnMgOFesn6M1uRQiHmrgYbGUwKN0Qb95In5rXbM3sDVGrunAGacBWJPeEoP7yF6OI1knEY8pMkM5kXoWt8HQMpz7vZhLpDO/ofFjwgzWmbTPAjHWxrLR8Wlju6QvpRIcnv6trRwQE1qlfj/I/Dq5YMXYR4B3pW/G9bLe0MT3VIBgn7mE1x4uu5nK+3g9ROVLm3eDfujaOfFOEremeWmmg28YpB9r6dUL0Ymxsq4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfXCyjZHM4oNkU/N2dd28vsbexJy9uPRGziLvpWNfbQ=;
 b=NcMRM+739thrczMF9Ag0ex6+v8PjMTA/yOc9lHmBcOzlEAKq6yb+bTICBt8BlmduL7OLkMmYtievqxsyQE3xFFcDuabhL2718emidN9ovEIhi7YBZZ5mWimf5FL3RwcqrD6CtNTHsxGFaB0Wg9Z2qPmloJte5I2NbHbNzakgDingTRWw4xN/mUWbILm7UDE1oJ9qL1DAJXFo0UDv/pC72h/3RwF/2+cISauNhyxHHgjcVrd5DSLE4EU9by+3dRmbykmz5SMMsuWIP/Z94ReUhlhtMHuVlxBEMyKBAVLv1KOi6VodvBVR9lYb58CXgxEPL3VKv3DpqIwrHLPPWtSB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=oracle.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfXCyjZHM4oNkU/N2dd28vsbexJy9uPRGziLvpWNfbQ=;
 b=bx8iD3gEFpfNVU7kBy7/gNmTjpsR71yhDNrqYhY8ir4IJfVvXvafJeBMpnsxzEMNbQA3xbRzG38FM9wJ9mg+zqmAQ78lbqMRAgfJjWh1p7jciYeQhbxiYUtDIQyr37fbmStomMuLRtu52YhjSgTC0mSmPTTmQaxK7GxQfKVQgg0=
Received: from SN4PR0201CA0068.namprd02.prod.outlook.com
 (2603:10b6:803:20::30) by SN6PR02MB4047.namprd02.prod.outlook.com
 (2603:10b6:805:2c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Thu, 22 Aug
 2019 08:17:13 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by SN4PR0201CA0068.outlook.office365.com
 (2603:10b6:803:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.15 via Frontend
 Transport; Thu, 22 Aug 2019 08:17:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2178.16
 via Frontend Transport; Thu, 22 Aug 2019 08:17:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i0iHQ-0004o3-65; Thu, 22 Aug 2019 01:17:12 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i0iHL-0003m0-2z; Thu, 22 Aug 2019 01:17:07 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x7M8H1h7018241;
        Thu, 22 Aug 2019 01:17:01 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i0iHF-0003iv-2L; Thu, 22 Aug 2019 01:17:01 -0700
Subject: Re: [PATCH 2/4] misc: xilinx_sdfec: Return -EFAULT if
 copy_from_user() fails
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190821070702.GB26957@mwanda>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <35a942ef-d8e9-0b81-932f-93ef9e552d50@xilinx.com>
Date:   Thu, 22 Aug 2019 10:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821070702.GB26957@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(2980300002)(199004)(189003)(81156014)(2486003)(52146003)(23676004)(9786002)(8936002)(81166006)(8676002)(26005)(426003)(31686004)(50466002)(2906002)(54906003)(229853002)(106002)(58126008)(110136005)(126002)(70206006)(186003)(70586007)(44832011)(336012)(446003)(316002)(486006)(2616005)(11346002)(476003)(36756003)(478600001)(4326008)(5660300002)(6246003)(36386004)(305945005)(6666004)(356004)(76176011)(230700001)(65806001)(65956001)(47776003)(6636002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4047;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 814c1017-1084-42da-1022-08d726d922ed
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:SN6PR02MB4047;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4047:
X-Microsoft-Antispam-PRVS: <SN6PR02MB40471C6A504503FFEAA45C33C6A50@SN6PR02MB4047.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 01371B902F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PFbyg4j5KccK2Fkn/vxpnksn9DtMpAdpsnGmzS7DAOx3Rhr9TQJbi4VT2T69mJ69FRJVvIA6/AcUl6Chuu5g/7D6SrEYD85wkb6KvaLMNHN3K2xyGeu61yJzl6doQe2pbFEapcFj69hhrYmJLuRjmueMesjbfFWdCY6CQMUGLKRRrYFlW29j8uRehQlO1plVUk3w8Xqv4W2XQsHpjEvDiNKlg9OZGzKD7mc8whejWLAQ1Kiw8KQ4/GO8vDzGsfSkLmS+WBuKMXhn84wt9ikhJTqGRZYGYW9jnPxL7E7fAbo7A/DP4X1Jrk0z9+yuDiRIdF5WSaPWoPsMmSWqQVf0JJDXdRp5+msg8BCevViTey/VMr3qiQpFwdYLHxuxPqKfFtHeKRTO7sAbZeYITZPosxCsr5LEOJCl8eVI54QJyRU=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2019 08:17:12.8137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 814c1017-1084-42da-1022-08d726d922ed
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 08. 19 9:07, Dan Carpenter wrote:
> The copy_from_user() funciton returns the number of bytes remaining to

typo here.

> be copied but we want to return -EFAULT to the user.
> 
> Fixes: 20ec628e8007 ("misc: xilinx_sdfec: Add ability to configure LDPC")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/misc/xilinx_sdfec.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index dc1b8b412712..813b82c59360 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -651,9 +651,10 @@ static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec, void __user *arg)
>  	if (!ldpc)
>  		return -ENOMEM;
>  
> -	ret = copy_from_user(ldpc, arg, sizeof(*ldpc));
> -	if (ret)
> +	if (copy_from_user(ldpc, arg, sizeof(*ldpc))) {
> +		ret = -EFAULT;
>  		goto err_out;
> +	}
>  
>  	if (xsdfec->config.code == XSDFEC_TURBO_CODE) {
>  		ret = -EIO;
> 

When typo fixed feel free to add my
Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
