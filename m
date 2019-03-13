Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0A5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1175E2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfCMKbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:31:20 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:41844 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfCMKbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:31:20 -0400
X-Greylist: delayed 2743 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Mar 2019 06:31:19 EDT
Received: from jain.kot-begemot.co.uk ([192.168.3.3] helo=smaug.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1h40S3-0007Fk-MU; Wed, 13 Mar 2019 09:45:31 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by smaug.kot-begemot.co.uk with esmtp (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1h40S2-0005gh-JM; Wed, 13 Mar 2019 09:45:30 +0000
Subject: Re: [PATCH] um: remove uses of variable length arrays
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190312133047.16201-1-brgl@bgdev.pl>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <56704758-ee74-0e9b-de1c-1dc94deda8d7@cambridgegreys.com>
Date:   Wed, 13 Mar 2019 09:45:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312133047.16201-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2019 13:30, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> While the affected code is run in user-mode, the build still warns
> about it. Convert all uses of VLA to dynamic allocations.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/um/os-Linux/umid.c | 36 +++++++++++++++++++++++++++---------
>   1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
> index 998fbb445458..e261656fe9d7 100644
> --- a/arch/um/os-Linux/umid.c
> +++ b/arch/um/os-Linux/umid.c
> @@ -135,12 +135,18 @@ static int remove_files_and_dir(char *dir)
>    */
>   static inline int is_umdir_used(char *dir)
>   {
> -	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
> -	char pid[sizeof("nnnnn\0")], *end;
> +	char pid[sizeof("nnnnn\0")], *end, *file;
>   	int dead, fd, p, n, err;
> +	size_t filelen;
>   
> -	n = snprintf(file, sizeof(file), "%s/pid", dir);
> -	if (n >= sizeof(file)) {
> +	err = asprintf(&file, "%s/pid", dir);
> +	if (err < 0)
> +		return 0;
> +
> +	filelen = strlen(file);
> +
> +	n = snprintf(file, filelen, "%s/pid", dir);
> +	if (n >= filelen) {
>   		printk(UM_KERN_ERR "is_umdir_used - pid filename too long\n");
>   		err = -E2BIG;
>   		goto out;
> @@ -185,6 +191,7 @@ static inline int is_umdir_used(char *dir)
>   out_close:
>   	close(fd);
>   out:
> +	free(file);
>   	return 0;
>   }
>   
> @@ -210,18 +217,21 @@ static int umdir_take_if_dead(char *dir)
>   
>   static void __init create_pid_file(void)
>   {
> -	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
> -	char pid[sizeof("nnnnn\0")];
> +	char pid[sizeof("nnnnn\0")], *file;
>   	int fd, n;
>   
> -	if (umid_file_name("pid", file, sizeof(file)))
> +	file = malloc(strlen(uml_dir) + UMID_LEN + sizeof("/pid\0"));
> +	if (!file)
>   		return;
>   
> +	if (umid_file_name("pid", file, sizeof(file)))
> +		goto out;
> +
>   	fd = open(file, O_RDWR | O_CREAT | O_EXCL, 0644);
>   	if (fd < 0) {
>   		printk(UM_KERN_ERR "Open of machine pid file \"%s\" failed: "
>   		       "%s\n", file, strerror(errno));
> -		return;
> +		goto out;
>   	}
>   
>   	snprintf(pid, sizeof(pid), "%d\n", getpid());
> @@ -231,6 +241,8 @@ static void __init create_pid_file(void)
>   		       errno);
>   
>   	close(fd);
> +out:
> +	free(file);
>   }
>   
>   int __init set_umid(char *name)
> @@ -385,13 +397,19 @@ __uml_setup("uml_dir=", set_uml_dir,
>   
>   static void remove_umid_dir(void)
>   {
> -	char dir[strlen(uml_dir) + UMID_LEN + 1], err;
> +	char *dir, err;
> +
> +	dir = malloc(strlen(uml_dir) + UMID_LEN + 1);
> +	if (!dir)
> +		return;
>   
>   	sprintf(dir, "%s%s", uml_dir, umid);
>   	err = remove_files_and_dir(dir);
>   	if (err)
>   		os_warn("%s - remove_files_and_dir failed with err = %d\n",
>   			__func__, err);
> +
> +	free(dir);
>   }
>   
>   __uml_exitcall(remove_umid_dir);
> 

Thanks for bringing it up. It helped me notice that this is actually broken.

PID can be more than 5 digits nowdays.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
