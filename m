Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C420C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBF5233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IQlVqVhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfHVNoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:44:04 -0400
Received: from mail-eopbgr780055.outbound.protection.outlook.com ([40.107.78.55]:47232
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfHVNoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:44:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6YDgktTytSwuTDy+B0n3Ik3VTwk3lRzNnEyVC+Ya5Rb2M+L0yLC5OnOvok7biac4w3NnvJ03lKOjIirAb8BdVj2i2GL3XvWK5VvgFCcKi5jd+xX6GthrtrDrXv6Iqz9dKuNZKNj5HF9NNnUf8N1eFJFcoZiKOIUzHnEVUJH7R1pCsJx77HAiLQFRsWZlf2ZbQb4UpR+V2O3iadgO4SteFqlh3cc2vyP5bBKVM/PJdKnigGFwavTKI5Eu1g2bi3m10MnmeMZORRfXMg7AEHsavV7zIyd7i1514fM4aluO6WZNoRcxaKyGznzaqer46r8MxTTkQzJOmLXF1bm9eE9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5CaZpM8mse+vwke7+ZiLoN/bAnJzCHVKpxNruo7lnM=;
 b=ii8fyVNXTlsmdQAnxS5gDwdESWGTxjMfCNVQu+N5uauVnhKiuAQUSCGn/rgZuWGQcxa4wXrxxxcA33e5Y0lFANAjzHWspajXSTzQbwJ3HjjPAsRj+POIn2zeu0RO07NMhffJT33eg+ViTR75Biy64eHAkjchYYP862zL8l4rvyEDtBBJm/227Pt1EfwO7ucW2kN6ZJBYW0hRm0ewzIyTrXUo8ROX5mhcOWpMjCwO+o3XvTvh2VDYQNPjFpqawquqU6qfRDucpiU1IBPrhBWudRXX+dVURzfg6fPQvb/vO93Z9YmEFo4AkLye1FL3ziMn06Dyu0d8woVUWEXQSUdEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5CaZpM8mse+vwke7+ZiLoN/bAnJzCHVKpxNruo7lnM=;
 b=IQlVqVhbiGcCip4kZrX3IydlMdgCt8EIMStEmZFrAZmhi/A7aqcAYrt0cZFfma2DdVUh3tzSpZzEgHnEzQGNAWSxSiiQgoV3Oh/nPJguKgmdusl6qopxao9eRAIhajXBooT+ay5AEqxQsC6Pl1oQMMk5Tgk/QDdKT9HsSwseB6w=
Received: from BYAPR02CA0027.namprd02.prod.outlook.com (2603:10b6:a02:ee::40)
 by BN7PR02MB4034.namprd02.prod.outlook.com (2603:10b6:406:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Thu, 22 Aug
 2019 13:43:58 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BYAPR02CA0027.outlook.office365.com
 (2603:10b6:a02:ee::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.18 via Frontend
 Transport; Thu, 22 Aug 2019 13:43:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2199.13
 via Frontend Transport; Thu, 22 Aug 2019 13:43:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i0nNc-000228-To; Thu, 22 Aug 2019 06:43:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i0nNX-0005zw-Qr; Thu, 22 Aug 2019 06:43:51 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x7MDhfjP027008;
        Thu, 22 Aug 2019 06:43:42 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i0nNN-0005zP-KV; Thu, 22 Aug 2019 06:43:41 -0700
Subject: Re: [RFC PATCH] hwmon: (iio_hwmon) Enable power exporting from IIO
To:     Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
References: <71aec0191e0e5f32cc760f95844d8ee215b48c7f.1565616579.git.michal.simek@xilinx.com>
 <906edfa3-9e7d-e8cc-29e3-e428b79ed0c2@roeck-us.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2bbbc5e9-7f11-1522-b827-0c0614bb9b69@xilinx.com>
Date:   Thu, 22 Aug 2019 15:43:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <906edfa3-9e7d-e8cc-29e3-e428b79ed0c2@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(36756003)(9786002)(126002)(50466002)(476003)(70206006)(70586007)(44832011)(6246003)(31696002)(446003)(336012)(426003)(11346002)(2616005)(305945005)(8676002)(81156014)(486006)(81166006)(53546011)(8936002)(26005)(5660300002)(186003)(478600001)(110136005)(356004)(2906002)(4326008)(316002)(36386004)(58126008)(31686004)(106002)(229853002)(47776003)(230700001)(52146003)(2486003)(76176011)(23676004)(65806001)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB4034;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0357fea1-607b-4919-8f66-08d72706c82e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BN7PR02MB4034;
X-MS-TrafficTypeDiagnostic: BN7PR02MB4034:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR02MB40340AC03297A249EDB6D7FDC6A50@BN7PR02MB4034.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01371B902F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KaNilu3v+D/JPw8RRkli+dyv/JfgVSMDe2Y5E2nWCeQ5DTe1/YY5DB8zBxd9wGZ/42+X4KVwf+0TY8NpW1ATR4LBZnGjCpLwJv3fA2+ZgWrtxvP5M1RenbW0r1UT9bUT+RRWYiEFGKpCIHFfuYFQFNPuhNjQXhwR8rR/kI3LDnATEEBvE96m0U8Co618ey9+s0CWiSz6VMH57ZN3bWlw2x3qba8eZX8KP/8Fi+ZothkNniH7o9TwzF9Fr+nM9GeVo+TVshFB1ycvFb3l0A8AbxvzaKKKoxxCz8EwfKUozkWoy6EeJF26eHTaTT77Yt+2lTinrIZJIoFy7KBJJLXbru47OWAK2DLAK4/N8xpwdDEL0Xd1rd/iCAh9Bo8Slwcp0UYR06Sy3ZzWzay7wnb+hCBZKEVtkrGzvztoZD0JSXM=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2019 13:43:57.4113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0357fea1-607b-4919-8f66-08d72706c82e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 08. 19 17:39, Guenter Roeck wrote:
> On 8/12/19 6:29 AM, Michal Simek wrote:
>> There is no reason why power channel shouldn't be exported as is done for
>> voltage, current, temperature and humidity.
>>
>> Power channel is available on iio ina226 driver.
>>
>> Tested on Xilinx ZCU102 board.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> But I don't think values are properly converted. Voltage1 is fine but the
>> rest is IMHO wrong. But this patch should enable power channel to be
>> shown
>> which looks good.
>>
> 
> No idea what is going on there. I don't really know what "scaled" units
> the iio subsystem reports. power is supposed to be reported to user space
> in micro-Watt. Is that what the scaled value from iio reports ?

I have take a look at it again.

root@zynqmp-debian:~/libiio/examples# sensors ina226_u76-*
ina226_u76-isa-0000
Adapter: ISA adapter
in1:          +0.01 V
in2:          +0.85 V
power1:        1.16 mW
curr1:        +1.60 A

from iio_monitor
voltage0          0.007 V
voltage1          0.848 V
power2            1.150 W
current3          1.361 A

from iio_info
 IIO context has 18 devices:
	iio:device0: ps_pmbus (buffer capable)
		9 channels found:
			voltage0:  (input, index: 0, format: le:U16/16>>0)
			3 channel-specific attributes found:
				attr  0: integration_time value: 0.001100
				attr  1: raw value: 3152
				attr  2: scale value: 0.002500000
			voltage1:  (input, index: 1, format: le:U16/16>>0)
			3 channel-specific attributes found:
				attr  0: integration_time value: 0.001100
				attr  1: raw value: 678
				attr  2: scale value: 1.250000000
			power2:  (input, index: 2, format: le:U16/16>>0)
			2 channel-specific attributes found:
				attr  0: raw value: 106
				attr  1: scale value: 12.500000000
			current3:  (input, index: 3, format: le:U16/16>>0)
			2 channel-specific attributes found:
				attr  0: raw value: 3152
				attr  1: scale value: 0.500000000


And if you look at power2 (in iio_info) then you see that calculation is
returning mili-Watts not micro-Watts.

And looking at it back it is also said there.

What:           /sys/bus/iio/devices/iio:deviceX/in_powerY_raw
KernelVersion:  4.5
Contact:        linux-iio@vger.kernel.org
Description:
                Raw (unscaled no bias removal etc.) power measurement from
                channel Y. The number must always be specified and
                unique to allow association with event codes. Units after
                application of scale and offset are milliwatts.

That means for power channel value needs to be multiply by 1000.

Are you OK with this solution?

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index aedb95fa24e3..7ea105bd195b 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -44,12 +44,20 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
        int ret;
        struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
        struct iio_hwmon_state *state = dev_get_drvdata(dev);
+       struct iio_channel *chan = &state->channels[sattr->index];
+       enum iio_chan_type type;

-       ret = iio_read_channel_processed(&state->channels[sattr->index],
-                                       &result);
+       ret = iio_read_channel_processed(chan, &result);
        if (ret < 0)
                return ret;

+       ret = iio_get_channel_type(chan, &type);
+       if (ret < 0)
+               return ret;
+
+       if (type == IIO_POWER)
+               result *= 1000;
+
        return sprintf(buf, "%d\n", result);
 }


Thanks,
Michal
