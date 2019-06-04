Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB8AC28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E36206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfFDPEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:04:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42690 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfFDPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:04:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C3D1726C9C8
Subject: Re: [PATCH] platform/chrome: fix crash during suspend
To:     "Yang, Hyungwoo" <hyungwoo.yang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kadam, Rushikesh S" <rushikesh.s.kadam@intel.com>,
        "jettrink@chromium.org" <jettrink@chromium.org>
References: <1559189034-11268-1-git-send-email-hyungwoo.yang@intel.com>
 <8b7a8d63-d9e4-6a9e-1b13-423441416c8a@collabora.com>
 <7A4F467111FEF64486F40DFE7DF3500A221AEE76@ORSMSX121.amr.corp.intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2fc73fbf-8d30-9aba-c12e-799e6f2a824f@collabora.com>
Date:   Tue, 4 Jun 2019 17:03:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7A4F467111FEF64486F40DFE7DF3500A221AEE76@ORSMSX121.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/5/19 20:15, Yang, Hyungwoo wrote:
>> On 30/5/19 6:03, Hyungwoo Yang wrote:
>>> Kernel crashes during suspend due to wrong conversion in suspend and 
>>> resume functions.
>>>
>>> Use the proper helper to get ishtp_cl_device instance.
>>>
>>> Signed-off-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
>>> ---
>>>  drivers/platform/chrome/cros_ec_ishtp.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c 
>>> b/drivers/platform/chrome/cros_ec_ishtp.c
>>> index e504d25..430731c 100644
>>> --- a/drivers/platform/chrome/cros_ec_ishtp.c
>>> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
>>> @@ -707,7 +707,7 @@ static int cros_ec_ishtp_reset(struct ishtp_cl_device *cl_device)
>>>   */
>>>  static int __maybe_unused cros_ec_ishtp_suspend(struct device 
>>> *device)  {
>>> -	struct ishtp_cl_device *cl_device = dev_get_drvdata(device);
>>> +	struct ishtp_cl_device *cl_device = ishtp_dev_to_cl_device(device);
>>>  	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
>>>  	struct ishtp_cl_data *client_data = 
>>> ishtp_get_client_data(cros_ish_cl);
>>>  
>>> @@ -722,7 +722,7 @@ static int __maybe_unused cros_ec_ishtp_suspend(struct device *device)
>>>   */
>>>  static int __maybe_unused cros_ec_ishtp_resume(struct device *device)  
>>> {
>>> -	struct ishtp_cl_device *cl_device = dev_get_drvdata(device);
>>> +	struct ishtp_cl_device *cl_device = ishtp_dev_to_cl_device(device);
>>>  	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
>>>  	struct ishtp_cl_data *client_data = 
>> ishtp_get_client_data(cros_ish_cl);
>>>  
>>>
>>
>> As this patch is a fix for '26a14267aff2 platform/chrome: Add ChromeOS EC ISHTP driver' which is still for-next material, do you mind if I squash both patches?
>>
>> If you don't mind I'll add your Signed-off and a small comment saying that you fixed this.
> 
> I don't mind. please do whatever you want. but it has dependency with https://patchwork.kernel.org/project/linux-input/list/?series=124780

What patches exactly? The link points me to a big list of patches. And do you
mean that this patch is a fix for a patch that didn't land yet and current code
is not wrong?

Thanks,
 Enric

> 
>>
>> Thanks,
>> Enric
> 
> 
> 
