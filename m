Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD46C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71A224E04
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfFDGwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:52:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726578AbfFDGwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:52:54 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x546l3df138989
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 02:52:52 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2swjgnu2ck-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 02:52:52 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Tue, 4 Jun 2019 07:52:50 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 07:52:44 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x546qhHh52166708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 06:52:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D983B42042;
        Tue,  4 Jun 2019 06:52:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D30F42041;
        Tue,  4 Jun 2019 06:52:42 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.152.224.114])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jun 2019 06:52:42 +0000 (GMT)
Subject: Re: [RFC PATCH 27/57] drivers: Unify the match prototype for
 bus_find_device with class_find_device
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        David Kershner <david.kershner@unisys.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-28-git-send-email-suzuki.poulose@arm.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Tue, 4 Jun 2019 08:52:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559577023-558-28-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19060406-4275-0000-0000-0000033C33AA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060406-4276-0000-0000-0000384C40C2
Message-Id: <89e63e55-5cad-3f88-402f-cd69aa8d18df@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.06.19 17:49, Suzuki K Poulose wrote:
> We have iterators for devices by bus and class, with a supplied
> "match" function to do the comparison. However, both of the helper
> function have slightly different prototype for the "match" argument.
>
>  int (*) (struct device *dev, void *data)  // bus_find_device
>   vs
>  int (*) (struct device *dev, const void *data) // class_find_device
>
> Unify the prototype by promoting the match function to use that of
> the class_find_device(). This will allow us to share the generic
> match helpers with class_find_device() users.
>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Sebastian Ott <sebott@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Cc: Michael Jamet <michael.jamet@intel.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: David Kershner <david.kershner@unisys.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/powerpc/platforms/pseries/ibmebus.c |  4 ++--
>  drivers/acpi/acpi_lpss.c                 |  4 ++--
>  drivers/acpi/sleep.c                     |  2 +-
>  drivers/acpi/utils.c                     |  4 ++--
>  drivers/base/bus.c                       |  2 +-
>  drivers/base/core.c                      | 10 +++++-----
>  drivers/base/platform.c                  |  2 +-
>  drivers/char/ipmi/ipmi_si_platform.c     |  2 +-
>  drivers/firmware/efi/dev-path-parser.c   |  4 ++--
>  drivers/hwtracing/coresight/coresight.c  |  6 +++---
>  drivers/i2c/i2c-core-acpi.c              |  2 +-
>  drivers/i2c/i2c-core-of.c                |  2 +-
>  drivers/iio/inkern.c                     |  2 +-
>  drivers/net/ethernet/ti/cpsw-phy-sel.c   |  4 ++--
>  drivers/net/ethernet/ti/davinci_emac.c   |  2 +-
>  drivers/net/ethernet/toshiba/tc35815.c   |  4 ++--
>  drivers/pci/probe.c                      |  2 +-
>  drivers/pci/search.c                     |  4 ++--
>  drivers/s390/cio/css.c                   |  4 ++--
>  drivers/s390/cio/device.c                |  4 ++--
>  drivers/s390/crypto/ap_bus.c             |  4 ++--
>  drivers/scsi/scsi_proc.c                 |  2 +-
>  drivers/thunderbolt/switch.c             |  4 ++--
>  drivers/usb/core/usb.c                   |  4 ++--
>  drivers/usb/phy/phy-am335x-control.c     |  4 ++--
>  drivers/usb/phy/phy-isp1301.c            |  4 ++--
>  drivers/visorbus/visorbus_main.c         |  4 ++--
>  include/linux/device.h                   | 13 ++++++-------
>  28 files changed, 54 insertions(+), 55 deletions(-)
>
...

> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index b9fc502..e440682 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -1365,7 +1365,7 @@ static int __match_card_device_with_id(struct device *dev, void *data)
>   * Helper function to be used with bus_find_dev
>   * matches for the queue device with a given qid
>   */
> -static int __match_queue_device_with_qid(struct device *dev, void *data)
> +static int __match_queue_device_with_qid(struct device *dev, const void *data)
>  {
>  	return is_queue_dev(dev) && to_ap_queue(dev)->qid == (int)(long) data;
>  }
> @@ -1374,7 +1374,7 @@ static int __match_queue_device_with_qid(struct device *dev, void *data)
>   * Helper function to be used with bus_find_dev
>   * matches any queue device with given queue id
>   */
> -static int __match_queue_device_with_queue_id(struct device *dev, void *data)
> +static int __match_queue_device_with_queue_id(struct device *dev, const void *data)
>  {
>  	return is_queue_dev(dev)
>  		&& AP_QID_QUEUE(to_ap_queue(dev)->qid) == (int)(long) data;
fine with me, Thanks
acked-by: Harald Freudenberger <freude@linux.ibm.com>


