Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EBBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD59E206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfCKNsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:48:42 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:54746 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727320AbfCKNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:48:42 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BDj2kd006573;
        Mon, 11 Mar 2019 13:48:21 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2r5r140ej0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 13:48:21 +0000
Received: from sarge.linuxathome.me (unknown [16.99.136.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 68F3459;
        Mon, 11 Mar 2019 13:48:17 +0000 (UTC)
Date:   Mon, 11 Mar 2019 13:48:14 +0000
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Borislav Petkov <bp@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: Please revert 7212e37cbdf9 from 4.4-stable
Message-ID: <20190311134814.GC30367@sarge.linuxathome.me>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=487 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903110100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Could you please revert

	7212e37cbdf9 x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

from 4.4-stable?

In 4.4-stable efi_runtime_lock as defined in drivers/firmware/efi/runtime-wrappers.c
is a spinlock (given it predates commit dce48e351c0d) and commit

	f331e766c4be x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

which 7212e37cbdf9 is a backport of, needs it to be a semaphore.

Cheers,
Hedi.
-- 
Be careful of reading health books, you might die of a misprint.
	-- Mark Twain
