Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD59C2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9AB205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575878810;
	bh=+p82qJRV+HdxV2eDzgujR97+XhTtLV6uMXNeoRqg/1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ASJN9Tyyx4DDyLrlPFtoCcPBNRLO0ITwXVe0/aoiMzr6ko1hjaEmj4jggJfdqudfS
	 KKopj769RonRpnj5E8s55DVjQ/B7moMkcgoWXLPj62uDsRs5iY+o/shbOgR2BEHQQf
	 En2HtzoCJDeHpRPgDAYfq68wMsELiy2DdyOyZ8FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLIIGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfLIIGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:06:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE19205ED;
        Mon,  9 Dec 2019 08:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575878807;
        bh=+p82qJRV+HdxV2eDzgujR97+XhTtLV6uMXNeoRqg/1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v70dICLIt2wSBD4f5PAvXKM1AYydl/wRec66JOgjWOeOcRTy8WdF2/6+9O18/LUDx
         WfF15Vi1Xyt+t2Mp7EYm5LDVSYdLEi7nMADrtVet2G7SnRP47LHdVgtO32e5D0q2J3
         UCpNb3gfRe129WO9VYBAYxh8ub7MqHcsaXSvkHKk=
Date:   Mon, 9 Dec 2019 09:06:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, arnd@arndb.de, michal.simek@xilinx.com,
        robh+dt@kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Kedareswara rao Appana <appanad@xilinx.com>,
        Srikanth Thokala <sthokal@xilinx.com>
Subject: Re: [PATCH v2 2/3] trafgen: xilinx: add axi traffic generator driver
Message-ID: <20191209080645.GA706232@kroah.com>
References: <8b3a446fc60cdd7d085203ce00c3f6bfba642437.1575871828.git.shubhrajyoti.datta@xilinx.com>
 <d66da6c524d01414562d3c15853174eeafa0c9fa.1575871828.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66da6c524d01414562d3c15853174eeafa0c9fa.1575871828.git.shubhrajyoti.datta@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 11:41:27AM +0530, shubhrajyoti.datta@gmail.com wrote:
> +/* Macro */

We know it's a macro, no need to say it :)

> +#define to_xtg_dev_info(n)	((struct xtg_dev_info *)dev_get_drvdata(n))

No need for the cast, and really, no need for this macro at all.  Please
drop it.

> + * FIXME: This structure is shared with the user application and
> + * hence need to be synchronized. We know these kind of structures
> + * should not be defined in the driver and this need to be fixed
> + * if found a proper placeholder (in uapi/).

Woah!  This isn't ok to leave as a fixme.  Please fix properly.

As it is, this is NOT a portable data structure by any means.

> + * FIXME: This structure is shared with the user application and
> + * hence need to be synchronized. We know these kind of structures
> + * should not be defined in the driver and this need to be fixed
> + * if found a proper placeholder (in uapi/).

Same here, this is just flat out not going to work.

> +static void xtg_access_rams(struct xtg_dev_info *tg, int where,
> +			    int count, int flags, u32 *data)
> +{
> +	u32 index;
> +
> +	switch (flags) {
> +	case XTG_WRITE_RAM_ZERO:
> +		memset_io(tg->regs + where, 0, count);
> +#ifdef CONFIG_PHYS_ADDR_T_64BIT

No #ifdef in .c code please, fix this correctly.

> +		writel(0x0, tg->regs + where +
> +			(XTG_COMMAND_RAM_MSB_OFFSET - XTG_COMMAND_RAM_OFFSET) +
> +			XTG_EXTCMD_RAM_BLOCK_SIZE - XTG_CMD_RAM_BLOCK_SIZE);
> +#endif
> +		break;
> +	case XTG_WRITE_RAM:
> +		for (index = 0; count > 0; index++, count -= 4)
> +			writel(data[index], tg->regs + where + index * 4);
> +#ifdef CONFIG_PHYS_ADDR_T_64BIT

Same here, and everywhere else.

> +/**
> + * xtg_sysfs_ioctl - Implements sysfs operations

sysfs is not an ioctl.  Please fix your naming.

> + * @dev: Device structure
> + * @buf: Value to write
> + * @opcode: Ioctl opcode
> + *
> + * Return: value read from the sysfs opcode.
> + */

Why are you creating kernel doc documentation for static functions?
That's not needed at all, right?

> +static ssize_t xtg_sysfs_ioctl(struct device *dev, const char *buf,
> +			       enum xtg_sysfs_ioctl_opcode opcode)
> +{
> +	struct xtg_dev_info *tg = to_xtg_dev_info(dev);
> +	unsigned long wrval;
> +	ssize_t status, rdval = 0;
> +
> +	if (opcode > XTG_GET_STREAM_TRANSFERCNT) {
> +		status = kstrtoul(buf, 0, &wrval);
> +		if (status < 0)
> +			return status;
> +	}
> +
> +	switch (opcode) {
> +	case XTG_GET_MASTER_CMP_STS:
> +		rdval = (readl(tg->regs + XTG_MCNTL_OFFSET) &
> +				XTG_MCNTL_MSTEN_MASK) ? 1 : 0;
> +		break;
> +
> +	case XTG_GET_MASTER_LOOP_EN:
> +		rdval = (readl(tg->regs + XTG_MCNTL_OFFSET) &
> +				XTG_MCNTL_LOOPEN_MASK) ? 1 : 0;
> +		break;
> +
> +	case XTG_GET_SLV_CTRL_REG:
> +		rdval = readl(tg->regs + XTG_SCNTL_OFFSET);
> +		break;
> +
> +	case XTG_GET_ERR_STS:
> +		rdval = readl(tg->regs + XTG_ERR_STS_OFFSET) &
> +				XTG_ERR_ALL_ERRS_MASK;
> +		break;
> +
> +	case XTG_GET_CFG_STS:
> +		rdval = readl(tg->regs + XTG_CFG_STS_OFFSET);
> +		break;
> +
> +	case XTG_GET_LAST_VALID_INDEX:
> +		rdval = (((tg->last_wr_valid_idx << 16) & 0xffff0000) |
> +				(tg->last_rd_valid_idx & 0xffff));
> +		break;
> +
> +	case XTG_GET_DEVICE_ID:
> +		rdval = tg->id;
> +		break;
> +
> +	case XTG_GET_RESOURCE:
> +		rdval = (unsigned long)tg->regs;
> +		break;
> +
> +	case XTG_GET_STATIC_ENABLE:
> +		rdval = readl(tg->regs + XTG_STATIC_CNTL_OFFSET);
> +		break;
> +
> +	case XTG_GET_STATIC_BURSTLEN:
> +		rdval = readl(tg->regs + XTG_STATIC_LEN_OFFSET);
> +		break;
> +
> +	case XTG_GET_STATIC_TRANSFERDONE:
> +		rdval = (readl(tg->regs + XTG_STATIC_CNTL_OFFSET) &
> +				XTG_STATIC_CNTL_TD_MASK);
> +		break;
> +
> +	case XTG_GET_STREAM_ENABLE:
> +		rdval = readl(tg->regs + XTG_STREAM_CNTL_OFFSET);
> +		break;
> +
> +	case XTG_GET_STREAM_TRANSFERLEN:
> +		rdval = (readl(tg->regs + XTG_STREAM_TL_OFFSET) &
> +				XTG_STREAM_TL_TLEN_MASK);
> +		break;
> +
> +	case XTG_GET_STREAM_TRANSFERCNT:
> +		rdval = ((readl(tg->regs + XTG_STREAM_TL_OFFSET) &
> +				XTG_STREAM_TL_TCNT_MASK) >>
> +				XTG_STREAM_TL_TCNT_SHIFT);
> +		break;
> +
> +	case XTG_GET_STREAM_TKTS1:
> +		rdval = readl(tg->regs + XTG_STREAM_TKTS1_OFFSET);
> +		break;
> +	case XTG_GET_STREAM_TKTS2:
> +		rdval = readl(tg->regs + XTG_STREAM_TKTS2_OFFSET);
> +		break;
> +	case XTG_GET_STREAM_TKTS3:
> +		rdval = readl(tg->regs + XTG_STREAM_TKTS3_OFFSET);
> +		break;
> +	case XTG_GET_STREAM_TKTS4:
> +		rdval = readl(tg->regs + XTG_STREAM_TKTS4_OFFSET);
> +		break;
> +
> +	case XTG_GET_STREAM_CFG:
> +		rdval = (readl(tg->regs + XTG_STREAM_CFG_OFFSET));
> +		break;
> +
> +	case XTG_START_MASTER_LOGIC:
> +		if (wrval)
> +			writel(readl(tg->regs + XTG_MCNTL_OFFSET) |
> +					XTG_MCNTL_MSTEN_MASK,
> +				tg->regs + XTG_MCNTL_OFFSET);
> +		break;
> +
> +	case XTG_MASTER_LOOP_EN:
> +		if (wrval)
> +			writel(readl(tg->regs + XTG_MCNTL_OFFSET) |
> +					XTG_MCNTL_LOOPEN_MASK,
> +				tg->regs + XTG_MCNTL_OFFSET);
> +		else
> +			writel(readl(tg->regs + XTG_MCNTL_OFFSET) &
> +					~XTG_MCNTL_LOOPEN_MASK,
> +				tg->regs + XTG_MCNTL_OFFSET);
> +		break;
> +
> +	case XTG_SET_SLV_CTRL_REG:
> +		writel(wrval, tg->regs + XTG_SCNTL_OFFSET);
> +		break;
> +
> +	case XTG_ENABLE_ERRORS:
> +		wrval &= XTG_ERR_ALL_ERRS_MASK;
> +		writel(wrval, tg->regs + XTG_ERR_EN_OFFSET);
> +		break;
> +
> +	case XTG_CLEAR_ERRORS:
> +		wrval &= XTG_ERR_ALL_ERRS_MASK;
> +		writel(readl(tg->regs + XTG_ERR_STS_OFFSET) | wrval,
> +		       tg->regs + XTG_ERR_STS_OFFSET);
> +		break;
> +
> +	case XTG_ENABLE_INTRS:
> +		if (wrval & XTG_MASTER_CMP_INTR) {
> +			pr_info("Enabling Master Complete Interrupt\n");
> +			writel(readl(tg->regs + XTG_ERR_EN_OFFSET) |
> +					XTG_ERR_EN_MSTIRQEN_MASK,
> +				tg->regs + XTG_ERR_EN_OFFSET);
> +		}
> +		if (wrval & XTG_MASTER_ERR_INTR) {
> +			pr_info("Enabling Interrupt on Master Errors\n");
> +			writel(readl(tg->regs + XTG_MSTERR_INTR_OFFSET) |
> +					XTG_MSTERR_INTR_MINTREN_MASK,
> +				tg->regs + XTG_MSTERR_INTR_OFFSET);
> +		}
> +		if (wrval & XTG_SLAVE_ERR_INTR) {
> +			pr_info("Enabling Interrupt on Slave Errors\n");
> +			writel(readl(tg->regs + XTG_SCNTL_OFFSET) |
> +					XTG_SCNTL_ERREN_MASK,
> +				tg->regs + XTG_SCNTL_OFFSET);
> +		}
> +		break;
> +
> +	case XTG_CLEAR_MRAM:
> +		xtg_access_rams(tg, tg->xtg_mram_offset,
> +				XTG_MASTER_RAM_SIZE,
> +				XTG_WRITE_RAM_ZERO, NULL);
> +		break;
> +
> +	case XTG_CLEAR_CRAM:
> +		xtg_access_rams(tg, XTG_COMMAND_RAM_OFFSET,
> +				XTG_COMMAND_RAM_SIZE,
> +				XTG_WRITE_RAM_ZERO, NULL);
> +		break;
> +
> +	case XTG_CLEAR_PRAM:
> +		xtg_access_rams(tg, XTG_PARAM_RAM_OFFSET,
> +				XTG_PARAM_RAM_SIZE,
> +				XTG_WRITE_RAM_ZERO, NULL);
> +		break;
> +
> +	case XTG_SET_STATIC_ENABLE:
> +		if (wrval) {
> +			wrval &= XTG_STATIC_CNTL_STEN_MASK;
> +			writel(readl(tg->regs + XTG_STATIC_CNTL_OFFSET) | wrval,
> +			       tg->regs + XTG_STATIC_CNTL_OFFSET);
> +		} else {
> +			writel(readl(tg->regs + XTG_STATIC_CNTL_OFFSET) &
> +				~XTG_STATIC_CNTL_STEN_MASK,
> +				tg->regs + XTG_STATIC_CNTL_OFFSET);
> +		}
> +		break;
> +
> +	case XTG_SET_STATIC_BURSTLEN:
> +		writel(wrval, tg->regs + XTG_STATIC_LEN_OFFSET);
> +		break;
> +
> +	case XTG_SET_STATIC_TRANSFERDONE:
> +		wrval |= XTG_STATIC_CNTL_TD_MASK;
> +		writel(readl(tg->regs + XTG_STATIC_CNTL_OFFSET) | wrval,
> +		       tg->regs + XTG_STATIC_CNTL_OFFSET);
> +		break;
> +
> +	case XTG_SET_STREAM_ENABLE:
> +		if (wrval) {
> +			rdval = readl(tg->regs + XTG_STREAM_CNTL_OFFSET);
> +			rdval |= XTG_STREAM_CNTL_STEN_MASK,
> +			writel(rdval,
> +			       tg->regs + XTG_STREAM_CNTL_OFFSET);
> +		} else {
> +			writel(readl(tg->regs + XTG_STREAM_CNTL_OFFSET) &
> +			       ~XTG_STREAM_CNTL_STEN_MASK,
> +			       tg->regs + XTG_STREAM_CNTL_OFFSET);
> +		}
> +		break;
> +
> +	case XTG_SET_STREAM_TRANSFERLEN:
> +		wrval &= XTG_STREAM_TL_TLEN_MASK;
> +		rdval = readl(tg->regs + XTG_STREAM_TL_OFFSET);
> +		rdval &= ~XTG_STREAM_TL_TLEN_MASK;
> +		writel(rdval | wrval,
> +		       tg->regs + XTG_STREAM_TL_OFFSET);
> +		break;
> +
> +	case XTG_SET_STREAM_TRANSFERCNT:
> +		wrval = ((wrval << XTG_STREAM_TL_TCNT_SHIFT) &
> +				XTG_STREAM_TL_TCNT_MASK);
> +		rdval = readl(tg->regs + XTG_STREAM_TL_OFFSET);
> +		rdval = rdval & ~XTG_STREAM_TL_TCNT_MASK;
> +		writel(rdval | wrval,
> +		       tg->regs + XTG_STREAM_TL_OFFSET);
> +		break;
> +
> +	case XTG_SET_STREAM_TKTS1:
> +		writel(wrval, tg->regs + XTG_STREAM_TKTS1_OFFSET);
> +		break;
> +	case XTG_SET_STREAM_TKTS2:
> +		writel(wrval, tg->regs + XTG_STREAM_TKTS2_OFFSET);
> +		break;
> +	case XTG_SET_STREAM_TKTS3:
> +		writel(wrval, tg->regs + XTG_STREAM_TKTS3_OFFSET);
> +		break;
> +	case XTG_SET_STREAM_TKTS4:
> +		writel(wrval, tg->regs + XTG_STREAM_TKTS4_OFFSET);
> +		break;
> +
> +	case XTG_SET_STREAM_CFG:
> +		writel(wrval, tg->regs + XTG_STREAM_CFG_OFFSET);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return rdval;
> +}
> +
> +/* Sysfs functions */
> +
> +static ssize_t id_show(struct device *dev,
> +		       struct device_attribute *attr, char *buf)
> +{
> +	ssize_t rdval = xtg_sysfs_ioctl(dev, buf, XTG_GET_DEVICE_ID);
> +
> +	return snprintf(buf, PAGE_SIZE, "%zd\n", rdval);

You "know" the size of the data for sysfs, no need for snprintf() or
friends at all, just use sprintf() please.

> +static ssize_t xtg_pram_read(struct file *filp, struct kobject *kobj,
> +			     struct bin_attribute *bin_attr,
> +			     char *buf, loff_t off, size_t count)
> +{
> +	pr_info("No read access to Parameter RAM\n");
> +
> +	return 0;
> +}


This is pointless, why do you have/need this?

Looks like a good way to spam the kernel log :(

And never use pr_* calls in a driver, always use dev_* instead.

> +	/*
> +	 * Create sysfs file entries for the device
> +	 */
> +	err = sysfs_create_group(&dev->kobj, &xtg_attributes);

You just raced with userspace and lost.  Set the attribute groups
pointer up correctly and the driver core will create/remove your
attributes for you.  This code does it wrong.

> +	dev_info(&pdev->dev, "Probing xilinx traffic generator success\n");

Do NOT be noisy when everything goes correctly.  Drivers should not
print out anything if all is well, please drop this.

thanks,

greg k-h
