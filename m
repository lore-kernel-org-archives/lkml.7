Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401C0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACE724CF3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfFDHsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:48:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:25293 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfFDHsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:48:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 00:47:59 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2019 00:47:56 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4] usb: create usb_debug_root for gadget only
In-Reply-To: <20190604073706.GA25045@kroah.com>
References: <1559633647-29040-1-git-send-email-chunfeng.yun@mediatek.com> <20190604073706.GA25045@kroah.com>
Date:   Tue, 04 Jun 2019 10:47:55 +0300
Message-ID: <87k1e123mc.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> +struct dentry *usb_debugfs_init(void)
>> +{
>> +	if (!usb_debug_root)
>> +		usb_debug_root = debugfs_create_dir("usb", NULL);
>> +
>> +	atomic_inc(&usb_debug_root_refcnt);
>> +
>> +	return usb_debug_root;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_debugfs_init);
>> +
>> +void usb_debugfs_cleanup(void)
>> +{
>> +	if (atomic_dec_and_test(&usb_debug_root_refcnt)) {
>> +		debugfs_remove_recursive(usb_debug_root);
>> +		usb_debug_root = NULL;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(usb_debugfs_cleanup);
>
> Only remove the debugfs subdir if the usbcore module is removed.  Create
> the debugfs subdir when the usbcore module is loaded.  No need for any
> reference counting of any sort at all.  No need to overthink this :)

There is a slight need to overthink. He wants to use the same directory
for gadget-only builds too :-)

-- 
balbi
