Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0003BC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD9D2133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KvHQ7roZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfJGGOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 02:14:30 -0400
Received: from mail-eopbgr720046.outbound.protection.outlook.com ([40.107.72.46]:30591
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfJGGOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:14:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwMPZ9uDWwxzqRePPM2Bxitt2XBwNEWkQnnIlCsQD8r9lUAyZMTxM6ozC1SHoi3gDjmXuLEp+Xr+qpk1RfaN+ypbEFK7ln/P+9+d6E7Pu64C0FF9xZOdBsDr/Z/YJsHMb3lzJ/vVuz6vusTxalZKU96jRmTHp7zYIzySZ/eYGleb/Ijjkb6I3jdgb9orLJ+Cqa7GQZ2KLAeeFKJrXMvbrii1gk/UWP5DYfIDV/KLp0eUUgBWru/OKf9MJGrKMcl9wrZoBmsz9ZfpiTXD1KDDcGU/AvpQ6Q/2+xTIdUMkYcSCBEMfQF5QA3vYui0QjLefqCjW0tO7/3c+321/8g631A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEr7e7XGFZ0ckZpOrtt8RMM/VSRi9f4QY0gpLHcGkUk=;
 b=ceh+nujgtO1YJAkPR9iDp4TaW+B4B/W7bAc5GB3d8GTMlL9M4MOX/noXaAWLoDaOtAWuBRrzmgzAdZMXdlh6n/F3buScqUtScCJWODHdNCtbSZXL0B81uyrQnCwSGR7yZoUt9dvAgI5mjdY98ot3sGc3zo6a96D0EBdISg9L+XVSohuFL4gGWe1aUCxcV2oJKgc8OaevY2Fd9xGZPywy14/r7TYO1alU/KPEnnVtBSruPb4yuXvE/FXmx7V0eARIT7GtXN3QGUtnPjfwHl8w0dISd3EeMAzoXrqz9YvqR689kdr35c+adoU0YKz5R9xLgSe/bFbJow41aCxwppsh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEr7e7XGFZ0ckZpOrtt8RMM/VSRi9f4QY0gpLHcGkUk=;
 b=KvHQ7roZXtVvkpXSLjaq6ncmReO4+kxOfOycQeRYTMQiY4yayLyYNyb92Ai9FezrJAOtXPNrfKt34G7cxVDUJjsVK6eQl6VpkqJzsXM8e8LAuTaybElzreAJp4r5xrEFoKgnWo6dyQh3WyLCtvPJ/0UALEUy/yjYf0fSFSlFy3A=
Received: from MWHPR02CA0002.namprd02.prod.outlook.com (2603:10b6:300:4b::12)
 by BN7PR02MB5124.namprd02.prod.outlook.com (2603:10b6:408:27::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Mon, 7 Oct
 2019 06:14:25 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by MWHPR02CA0002.outlook.office365.com
 (2603:10b6:300:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23 via Frontend
 Transport; Mon, 7 Oct 2019 06:14:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2327.21
 via Frontend Transport; Mon, 7 Oct 2019 06:14:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iHMHn-0007jJ-G4; Sun, 06 Oct 2019 23:14:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iHMHi-0004Ps-D0; Sun, 06 Oct 2019 23:14:18 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x976EE3O010017;
        Sun, 6 Oct 2019 23:14:14 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iHMHe-0004Nj-I5; Sun, 06 Oct 2019 23:14:14 -0700
Subject: Re: [PATCH 1/2] dt-bindings: firmware: Add bindings for Versal
 firmware
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1569613206-20189-1-git-send-email-jolly.shah@xilinx.com>
 <1569613206-20189-2-git-send-email-jolly.shah@xilinx.com>
 <20191004161825.GB854302@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <765978d6-10b3-b0e3-cf69-3c23104a8b6f@xilinx.com>
Date:   Mon, 7 Oct 2019 08:14:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004161825.GB854302@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(11346002)(336012)(2486003)(6666004)(356004)(23676004)(70206006)(70586007)(6246003)(76176011)(31686004)(229853002)(230700001)(6636002)(476003)(126002)(44832011)(486006)(31696002)(426003)(2906002)(2616005)(446003)(26005)(14444005)(186003)(4326008)(65806001)(65956001)(47776003)(8936002)(81156014)(8676002)(81166006)(50466002)(316002)(36756003)(36386004)(58126008)(110136005)(106002)(478600001)(9786002)(305945005)(7416002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5124;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:3;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be2a6d6d-80ae-4a3d-c998-08d74aed998c
X-MS-TrafficTypeDiagnostic: BN7PR02MB5124:
X-Microsoft-Antispam-PRVS: <BN7PR02MB512408BBF4A7FC2E76476912C69B0@BN7PR02MB5124.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01834E39B7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuUqNk8FdmO4eCUbnzTLfIHX9TQm9ijw9WgbuzFU+NY7YFgHgvr/JXPtYBsq6ABKcSCLGu698eutjdD16yAwjfLaYWgAs5sbDIBz1rtcrXXgJrUSu3ZsEsZKIOGz7j/LzF1w3NlmTmuXRH5ji/dhujn2ClLe9yFYdTMCHloSadLNB5fDBvqT0imG3IHE3TRVANcqxoJ0U5LpcJw/NhqtcRWlTfXYbRX93sfXhhv8eTPPWPwdOsZTkj0AT2xa0XdwikEdSNWPuF+Gtag6SgJiym98JdakSM2H8hF/nOkewni5IYG6B47omeyCIDq6a94DvPg/9mlp8jPrwsgKUhd2VfS8Jcq6HMyR667ytjQBes1tIhNiNTVnpNlQ73/cT3UoWzCSRpNFxNXMrhmLbuV6RlH3+LcQm7mR0+Uc8Ta3LY0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2019 06:14:23.8938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2a6d6d-80ae-4a3d-c998-08d74aed998c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 10. 19 18:18, Greg KH wrote:
> On Fri, Sep 27, 2019 at 12:40:05PM -0700, Jolly Shah wrote:
>> ZynqMP firmware driver can be used for versal also.
>> Add versal compatible string to zynqmp firmware driver
>> doc.
>>
>> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
>> ---
>>  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
>> index a4fe136..18c3aea 100644
>> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
>> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
>> @@ -11,7 +11,9 @@ power management service, FPGA service and other platform management
>>  services.
>>  
>>  Required properties:
>> - - compatible:	Must contain:	"xlnx,zynqmp-firmware"
>> + - compatible:	Must contain any of below:
>> +		"xlnx,zynqmp-firmware" for Zynq Ultrascale+ MPSoC
>> +		"xlnx,versal-firmware" for Versal
>>   - method:	The method of calling the PM-API firmware layer.
>>  		Permitted values are:
>>  		  - "smc" : SMC #0, following the SMCCC
>> @@ -21,6 +23,8 @@ Required properties:
>>  Example
>>  -------
>>  
>> +Zynq Ultrascale+ MPSoC
>> +----------------------
>>  firmware {
>>  	zynqmp_firmware: zynqmp-firmware {
>>  		compatible = "xlnx,zynqmp-firmware";
>> @@ -28,3 +32,13 @@ firmware {
>>  		...
>>  	};
>>  };
>> +
>> +Versal
>> +------
>> +firmware {
>> +	versal_firmware: versal-firmware {
>> +		compatible = "xlnx,versal-firmware";
>> +		method = "smc";
>> +		...
>> +	};
>> +};
>> -- 
>> 2.7.4
>>
> 
> 
> For new dt bindings, don't you have to cc: the dt maintainers and
> mailing list?  I can't take the patch until I get an ack from them.

Yes dt guys should be in CC and normally I am taking this via ARM soc tree.

Jolly: Please resend

Thanks,
Michal
