Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E22C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE1F207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfCISjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:39:36 -0500
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:53199 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbfCISjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:39:36 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B2DBC180A812C;
        Sat,  9 Mar 2019 18:39:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: key04_709d79fe7bf02
X-Filterd-Recvd-Size: 2564
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat,  9 Mar 2019 18:39:33 +0000 (UTC)
Message-ID: <d57e41f96a23f63aeb720d0ea73ba2b2bed0a938.camel@perches.com>
Subject: Re: [PATCH 1/5] Staging: rtl8723bs: os_dep: Fix assignment in if
 condition
From:   Joe Perches <joe@perches.com>
To:     Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 09 Mar 2019 10:39:32 -0800
In-Reply-To: <20190309183047.10781-2-gui.maeoka@gmail.com>
References: <20190309183047.10781-1-gui.maeoka@gmail.com>
         <20190309183047.10781-2-gui.maeoka@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-09 at 15:30 -0300, Guilherme Tadashi Maeoka wrote:
> Fix an assignment in if condition.
> 
> Signed-off-by: Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/osdep_service.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
> index 73b87da15eb2..c7fdcc6bbae3 100644
> --- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
> +++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
> @@ -162,7 +162,9 @@ static int retriveFromFile(char *path, u8 *buf, u32 sz)
>  	struct file *fp;
>  
>  	if (path && buf) {
> -		if (0 == (ret =openFile(&fp, path, O_RDONLY, 0))) {
> +		ret = openFile(&fp, path, O_RDONLY, 0);
> +
> +		if (ret == 0) {
>  			DBG_871X("%s openFile path:%s fp =%p\n", __func__, path , fp);
>  
>  			oldfs = get_fs(); set_fs(KERNEL_DS);

More common kernel style would be to rewrite the function
(and to fix the typo of retrieve) to something like:  

static int retrieveFromFile(char *path, u8 *buf, u32 sz)
{
	int ret;
	mm_segment_t oldfs;
	struct file *fp;

	if (!path || !buf) {
		DBG_871X("%s NULL pointer\n", __func__);
		return -EINVAL;
	}

	ret = openFile(&fp, path, O_RDONLY, 0);
	if (ret) {
		DBG_871X("%s openFile path:%s Fail, ret:%d\n",
			 __func__, path, ret);
		return ret;
	}

	DBG_871X("%s openFile path:%s fp =%p\n", __func__, path , fp);

	oldfs = get_fs();
	set_fs(KERNEL_DS);
	ret = readFile(fp, buf, sz);
	set_fs(oldfs);
	closeFile(fp);

	DBG_871X("%s readFile, ret:%d\n", __func__, ret);

	return ret;
}


