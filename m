Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECEEC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EBE2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="iUOInlIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfHZLUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:20:32 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:54948 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbfHZLUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:20:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 8EB5227E064D;
        Mon, 26 Aug 2019 13:20:28 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ikw_e-efbxjL; Mon, 26 Aug 2019 13:20:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 29B5127E0E5F;
        Mon, 26 Aug 2019 13:20:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 29B5127E0E5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1566818428;
        bh=tsMZPKKNKbI1bxBzVmtUnATkR6Uyc9slc45iBOLgVIQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=iUOInlIyEEGDWg1LIFSHrTBY4de3dAi8xD/6oxQKuKl+CdMK2LPcp6SG2d97XVVeO
         2O5VituFjcDVop/SsmJFsf0yBdOqn2xrdXjQheWns6/cgICU3sMwUb5as7MvfhiGiS
         eRtsUdy+cmA5ien2eKIlM+E1puAcWWaEvcHc6HaE=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IdXClkO_c_9L; Mon, 26 Aug 2019 13:20:28 +0200 (CEST)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [192.168.40.202])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 0B6EB27E064D;
        Mon, 26 Aug 2019 13:20:28 +0200 (CEST)
Date:   Mon, 26 Aug 2019 13:20:28 +0200 (CEST)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Guillaume Missonnier <gmissonnier@kalray.eu>
Message-ID: <1678802062.58145473.1566818428010.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20190822000652.GF9511@lst.de>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu> <20190822000652.GF9511@lst.de>
Subject: Re: [PATCH v2] nvme: allow 64-bit results in passthru commands
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Topic: nvme: allow 64-bit results in passthru commands
Thread-Index: 0b2C8OxcS39CpE4vfrdjGI09niL36A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 22 Aug, 2019, at 02:06, Christoph Hellwig hch@lst.de wrote:

> On Fri, Aug 16, 2019 at 11:47:21AM +0200, Marta Rybczynska wrote:
>> It is not possible to get 64-bit results from the passthru commands,
>> what prevents from getting for the Capabilities (CAP) property value.
>> 
>> As a result, it is not possible to implement IOL's NVMe Conformance
>> test 4.3 Case 1 for Fabrics targets [1] (page 123).
>> 
>> This issue has been already discussed [2], but without a solution.
>> 
>> This patch solves the problem by adding new ioctls with a new
>> passthru structure, including 64-bit results. The older ioctls stay
>> unchanged.
> 
> Ok, with my idea not being suitable I think I'm fine with this approach, a
> little nitpick below:
> 
>> +static bool is_admin_cmd(unsigned int cmd)
>> +{
>> +	if ((cmd == NVME_IOCTL_ADMIN_CMD) || (cmd == NVME_IOCTL_ADMIN64_CMD))
>> +		return true;
>> +	return false;
>> +}
> 
> No need for the inner braces.  But I'm actually not sure the current
> code structure is very suitable for extending it.
> 
>> +
>>  static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>>  		unsigned int cmd, unsigned long arg)
>>  {
>> @@ -1418,13 +1473,13 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t
>> mode,
>>  	 * seperately and drop the ns SRCU reference early.  This avoids a
>>  	 * deadlock when deleting namespaces using the passthrough interface.
>>  	 */
>> -	if (cmd == NVME_IOCTL_ADMIN_CMD || is_sed_ioctl(cmd)) {
>> +	if (is_admin_cmd(cmd) || is_sed_ioctl(cmd)) {
> 
> So maybe for this check we should have a is_ctrl_iocl() helper instead
> that includes the is_sed_ioctl check.
> 
>>  		struct nvme_ctrl *ctrl = ns->ctrl;
>>  
>>  		nvme_get_ctrl(ns->ctrl);
>>  		nvme_put_ns_from_disk(head, srcu_idx);
>>  
>> -		if (cmd == NVME_IOCTL_ADMIN_CMD)
>> +		if (is_admin_cmd(cmd))
>>  			ret = nvme_user_cmd(ctrl, NULL, argp);
>>  		else
>>  			ret = sed_ioctl(ctrl->opal_dev, cmd, argp);
> 
> And then we can move this whole branch into a helper function,
> which then switches on the ioctl cmd, with sed_ioctl as the fallback.

Do you mean something like this?

+static bool is_ctrl_ioctl(unsigned int cmd)
+{
+	if (cmd == NVME_IOCTL_ADMIN_CMD || cmd == NVME_IOCTL_ADMIN64_CMD)
+		return true;
+	if (is_sed_ioctl(cmd))
+		return true;
+	return false;
+}
+
+static int nvme_handle_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
+				  void __user *argp,
+				  struct nvme_ns_head *head,
+				  int srcu_idx)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	int ret;
+
+	nvme_get_ctrl(ns->ctrl);
+	nvme_put_ns_from_disk(head, srcu_idx);
+
+	switch (cmd) {
+	case NVME_IOCTL_ADMIN_CMD:
+		ret = nvme_user_cmd(ctrl, NULL, argp);
+		break;
+	case NVME_IOCTL_ADMIN64_CMD:
+		ret = nvme_user_cmd64(ctrl, NULL, argp);
+		break;
+	default:
+		ret = sed_ioctl(ctrl->opal_dev, cmd, argp);
+		break;
+	}
+	nvme_put_ctrl(ctrl);
+	return ret;
+}
+
 static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
@@ -1418,20 +1501,8 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	 * seperately and drop the ns SRCU reference early.  This avoids a
 	 * deadlock when deleting namespaces using the passthrough interface.
 	 */
-	if (cmd == NVME_IOCTL_ADMIN_CMD || is_sed_ioctl(cmd)) {
-		struct nvme_ctrl *ctrl = ns->ctrl;
-
-		nvme_get_ctrl(ns->ctrl);
-		nvme_put_ns_from_disk(head, srcu_idx);
-
-		if (cmd == NVME_IOCTL_ADMIN_CMD)
-			ret = nvme_user_cmd(ctrl, NULL, argp);
-		else
-			ret = sed_ioctl(ctrl->opal_dev, cmd, argp);
-
-		nvme_put_ctrl(ctrl);
-		return ret;
-	}
+	if (is_ctrl_ioctl(cmd))
+		return nvme_handle_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
 
 	switch (cmd) {
 	case NVME_IOCTL_ID:

Regards,
Marta
