Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5BB20657
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfCDQMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:12:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726862AbfCDQMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:12:30 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24G4vC8124087
        for <linux-kernel@vger.kernel.org>; Mon, 4 Mar 2019 11:12:28 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r16c13a0c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 11:12:28 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 4 Mar 2019 16:12:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Mar 2019 16:12:23 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x24GCMge27000896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Mar 2019 16:12:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D22FBAE058;
        Mon,  4 Mar 2019 16:12:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC581AE053;
        Mon,  4 Mar 2019 16:12:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.84])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Mar 2019 16:12:20 +0000 (GMT)
Subject: Re: [PATCH] vfs: Move kernel_read_file() to fs/read_write.c
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 Mar 2019 11:12:10 -0500
In-Reply-To: <155171231301.4764.5429281379303710262.stgit@warthog.procyon.org.uk>
References: <155171231301.4764.5429281379303710262.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030416-0012-0000-0000-000002FE636F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030416-0013-0000-0000-0000213566AB
Message-Id: <1551715930.10911.468.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-04 at 15:11 +0000, David Howells wrote:
> Move kernel_read_file() to fs/read_write.c and out of fs/exec.c as it's not
> actually used by anything in the execve subsystem.

All files being opened by the kernel should be calling one of these
helper routines.  Has that changed?

Mimi

> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
> 
>  fs/exec.c       |  106 -------------------------------------------------------
>  fs/read_write.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+), 106 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index fb72d36f7823..cbb1a9cd25ca 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -61,7 +61,6 @@
>  #include <linux/pipe_fs_i.h>
>  #include <linux/oom.h>
>  #include <linux/compat.h>
> -#include <linux/vmalloc.h>
> 
>  #include <linux/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -892,111 +891,6 @@ struct file *open_exec(const char *name)
>  }
>  EXPORT_SYMBOL(open_exec);
> 
> -int kernel_read_file(struct file *file, void **buf, loff_t *size,
> -		     loff_t max_size, enum kernel_read_file_id id)
> -{
> -	loff_t i_size, pos;
> -	ssize_t bytes = 0;
> -	int ret;
> -
> -	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
> -		return -EINVAL;
> -
> -	ret = deny_write_access(file);
> -	if (ret)
> -		return ret;
> -
> -	ret = security_kernel_read_file(file, id);
> -	if (ret)
> -		goto out;
> -
> -	i_size = i_size_read(file_inode(file));
> -	if (i_size <= 0) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> -		ret = -EFBIG;
> -		goto out;
> -	}
> -
> -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
> -		*buf = vmalloc(i_size);
> -	if (!*buf) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	pos = 0;
> -	while (pos < i_size) {
> -		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
> -		if (bytes < 0) {
> -			ret = bytes;
> -			goto out;
> -		}
> -
> -		if (bytes == 0)
> -			break;
> -	}
> -
> -	if (pos != i_size) {
> -		ret = -EIO;
> -		goto out_free;
> -	}
> -
> -	ret = security_kernel_post_read_file(file, *buf, i_size, id);
> -	if (!ret)
> -		*size = pos;
> -
> -out_free:
> -	if (ret < 0) {
> -		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
> -			vfree(*buf);
> -			*buf = NULL;
> -		}
> -	}
> -
> -out:
> -	allow_write_access(file);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(kernel_read_file);
> -
> -int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
> -			       loff_t max_size, enum kernel_read_file_id id)
> -{
> -	struct file *file;
> -	int ret;
> -
> -	if (!path || !*path)
> -		return -EINVAL;
> -
> -	file = filp_open(path, O_RDONLY, 0);
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> -
> -	ret = kernel_read_file(file, buf, size, max_size, id);
> -	fput(file);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
> -
> -int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> -			     enum kernel_read_file_id id)
> -{
> -	struct fd f = fdget(fd);
> -	int ret = -EBADF;
> -
> -	if (!f.file)
> -		goto out;
> -
> -	ret = kernel_read_file(f.file, buf, size, max_size, id);
> -out:
> -	fdput(f);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
> -
>  ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
>  {
>  	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
> diff --git a/fs/read_write.c b/fs/read_write.c
> index ff3c5e6f87cf..555dcaec00ac 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -20,6 +20,7 @@
>  #include <linux/compat.h>
>  #include <linux/mount.h>
>  #include <linux/fs.h>
> +#include <linux/vmalloc.h>
>  #include "internal.h"
> 
>  #include <linux/uaccess.h>
> @@ -1362,6 +1363,111 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
> 
>  #endif
> 
> +int kernel_read_file(struct file *file, void **buf, loff_t *size,
> +		     loff_t max_size, enum kernel_read_file_id id)
> +{
> +	loff_t i_size, pos;
> +	ssize_t bytes = 0;
> +	int ret;
> +
> +	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
> +		return -EINVAL;
> +
> +	ret = deny_write_access(file);
> +	if (ret)
> +		return ret;
> +
> +	ret = security_kernel_read_file(file, id);
> +	if (ret)
> +		goto out;
> +
> +	i_size = i_size_read(file_inode(file));
> +	if (i_size <= 0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> +		ret = -EFBIG;
> +		goto out;
> +	}
> +
> +	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
> +		*buf = vmalloc(i_size);
> +	if (!*buf) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	pos = 0;
> +	while (pos < i_size) {
> +		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
> +		if (bytes < 0) {
> +			ret = bytes;
> +			goto out;
> +		}
> +
> +		if (bytes == 0)
> +			break;
> +	}
> +
> +	if (pos != i_size) {
> +		ret = -EIO;
> +		goto out_free;
> +	}
> +
> +	ret = security_kernel_post_read_file(file, *buf, i_size, id);
> +	if (!ret)
> +		*size = pos;
> +
> +out_free:
> +	if (ret < 0) {
> +		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
> +			vfree(*buf);
> +			*buf = NULL;
> +		}
> +	}
> +
> +out:
> +	allow_write_access(file);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file);
> +
> +int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
> +			       loff_t max_size, enum kernel_read_file_id id)
> +{
> +	struct file *file;
> +	int ret;
> +
> +	if (!path || !*path)
> +		return -EINVAL;
> +
> +	file = filp_open(path, O_RDONLY, 0);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	ret = kernel_read_file(file, buf, size, max_size, id);
> +	fput(file);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
> +
> +int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> +			     enum kernel_read_file_id id)
> +{
> +	struct fd f = fdget(fd);
> +	int ret = -EBADF;
> +
> +	if (!f.file)
> +		goto out;
> +
> +	ret = kernel_read_file(f.file, buf, size, max_size, id);
> +out:
> +	fdput(f);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
> +
>  static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
>  		  	   size_t count, loff_t max)
>  {
> 

